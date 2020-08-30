import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Product_review.dart';
import 'package:shoppingapp/modal/Product_variations.dart';
import 'package:shoppingapp/modal/Recentview.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/order_page.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/utils/commons/add_favorite.dart';
import 'package:shoppingapp/utils/commons/show_dialog.dart';
import 'package:shoppingapp/utils/dialog_comment.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/recentId.dart';
import 'package:shoppingapp/utils/util/shared_preferences_helper.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/product_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';
import 'package:shoppingapp/widgets/product_detail/slider_dot.dart';

class ProductDetailPage_id extends StatefulWidget {
  ProductDetailPage_id({
    Key key,
    @required this.product,
  }) : super(key: key);
  final int product;

  @override
  _ProductDetailPage_idState createState() => _ProductDetailPage_idState();
}

class _ProductDetailPage_idState extends State<ProductDetailPage_id>
    with TickerProviderStateMixin {
  bool isliked;

  AnimationController controller;
  SQL_Helper helper = new SQL_Helper();
  final formKey = GlobalKey<FormState>();
  bool isloading = false;
  int id;
  String name, email, photo;
  String vriationName = '';
  double rateing = 5;
  TextEditingController comment;
  SQL_Rercent helperRecent = new SQL_Rercent();
  Recentview recentview;
  Cart cart;
  int checkboxValueA, checkboxValueB;
  List<Product_variations> product_variations;
  Animation<double> animation;
  Future<List<ProductModel>> productRelated;
  int _carouselCurrentPage = 0;
  ScrollController tempScroll = ScrollController();
  double radius = 40;
  int piece = 1;
  static int count = 0;
  int idProduct;
  List<Product_review> product_review = new List<Product_review>();
  ProductModel productModel;

  @override
  void initState() {
    ProductService.getProduct(widget.product).then((value) => {
          setState(() {
            productModel = value;
            print("gppppppppp"+value.related_ids.toString());
            productRelated =  ProductService.getRelatedProducts(value.related_ids.toString());

          })
        });

    ProductService.getReviewer(widget.product).then((usersFromServer) {
      setState(() {
        product_review = usersFromServer;
      });
    });
    ProductService.getVriationProducts(widget.product)
        .then((usersFromServer) {
      setState(() {
        product_variations = usersFromServer;
      });
    });
    fetchUserId();
    countCart();
    tempScroll = ScrollController()
      ..addListener(() {
        setState(() {
          print(tempScroll.position.viewportDimension);
        });
      });
    _addtoRecentview();

    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  void _addtoRecentview() async {
    recentview = new Recentview(widget.product, count++);
    int result;
    if (await helperRecent.checkItem(recentview.id) == true) {
      result = await helperRecent.insertRecentView(recentview);
    } else {
      result = await helperRecent.updateRecentView(recentview);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = false;
  List<Widget> imageSlider;

  Widget _buildBox({Color color, String name}) {
    return Container(
      child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              name,
              maxLines: 1,
              style: TextStyle(color: Color(0xFF5D6A78), fontSize: 12),
            ),
          )),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF5D6A78), width: 1),
          borderRadius: BorderRadius.circular(32)),
      margin: EdgeInsets.only(right: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    if (productModel != null) {
      imageSlider = productModel.images
          .map((item) => Container(
                padding: EdgeInsets.only(bottom: 12),
                height: ScreenUtil.getHeight(context) / 1.3,
                child: Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: ScreenUtil.getWidth(context),
                            height: ScreenUtil.getHeight(context) / 1.3,
                            child: CachedNetworkImage(
                              imageUrl: (productModel.images == null &&
                                      productModel.images.isEmpty)
                                  ? 'http://arabimagefoundation.com/images/defaultImage.png'
                                  : item.src,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ))),
                  ],
                ),
              ))
          .toList();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                productModel == null
                    ? Container():CarouselSlider(
                  items: imageSlider,
                  options: CarouselOptions(
                      autoPlay: true,
                      height: ScreenUtil.getHeight(context) / 1.9,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _carouselCurrentPage = index;
                        });
                      }),
                ),
                Container(
                  constraints: BoxConstraints.expand(
                    height: 80,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  padding: const EdgeInsets.only(top: 40, left: 18, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                        child: Badge(
                          animationDuration: Duration(milliseconds: 1500),
                          badgeColor: themeColor.getColor(),
                          alignment: Alignment(1, 0),
                          position: BadgePosition.bottomRight(),
                          padding: EdgeInsets.all(5),
                          badgeContent: Text(
                            Provider.of<ThemeNotifier>(context)
                                .countCart
                                .toString(),
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/ic_shopping_cart.svg",
                            color: Colors.grey,
                            height: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                productModel == null
                    ? Container()
                    : DraggableScrollableSheet(
                        maxChildSize: 1,
                        initialChildSize: .53,
                        minChildSize: .53,
                        builder: (context, scrollController) {
                          return Container(
                            decoration: !scrollController.hasClients
                                ? BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(26),
                                      topRight: Radius.circular(26),
                                    ))
                                : BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(scrollController
                                                  .position.viewportDimension >
                                              660
                                          ? 0
                                          : 26),
                                      topRight: Radius.circular(scrollController
                                                  .position.viewportDimension >
                                              660
                                          ? 0
                                          : 26),
                                    ),
                                    color: Colors.white),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: AppTheme.padding.copyWith(),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.2),
                                            blurRadius:
                                                6.0, // soften the shadow
                                            spreadRadius:
                                                0.0, //extend the shadow
                                            offset: Offset(
                                              0.0, // Move to right 10  horizontally
                                              1.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(26)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        SliderDotProductDetail(
                                          current: _carouselCurrentPage,
                                          list: productModel.images,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 14),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        2,
                                                    child: Text(
                                                        productModel.name,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xFF5D6A78))),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      RatingBar(
                                                        initialRating: double
                                                            .parse(productModel
                                                                .averageRating),
                                                        itemSize: 18.0,
                                                        tapOnlyMode: true,
                                                        ignoreGestures: true,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Container(
                                                          height: 12,
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/icons/ic_star.svg",
                                                            color: themeColor
                                                                .getColor(),
                                                            width: 9,
                                                          ),
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        productModel
                                                            .averageRating,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 12, bottom: 8),
                                          height: 33,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                productModel.categories.length,
                                            itemBuilder: (_, i) => _buildBox(
                                                name: productModel
                                                    .categories[i].name),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 12),
                                          child: ExpandablePanel(
                                            header: Text(
                                              getTransrlate(context, 'showAll'),
                                              style: TextStyle(
                                                  color: themeColor.getColor(),
                                                  fontSize: 12),
                                            ),
                                            expanded: Text(
                                              (parse(productModel.sortDescription
                                                                  .toString()
                                                                  .trim())
                                                              .body
                                                              .text
                                                              .trim()
                                                              .length >
                                                          0 ||
                                                      productModel
                                                              .sortDescription
                                                              .toString()
                                                              .trim() ==
                                                          '')
                                                  ? parse(productModel
                                                          .sortDescription
                                                          .toString()
                                                          .trim())
                                                      .body
                                                      .text
                                                      .trim()
                                                  : "Best",
                                              softWrap: true,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xFF5D6A78),
                                                letterSpacing: 0.6,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  getTransrlate(
                                                          context, 'price') +
                                                      "  ",
                                                  style: TextStyle(
                                                      color:
                                                          themeColor.getColor(),
                                                      fontSize: 18),
                                                ),
                                                productModel.variations.isEmpty
                                                    ? Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            productModel.price +
                                                                ' ' +
                                                                productModel
                                                                    .Currancy,
                                                            style: TextStyle(
                                                                color: themeColor
                                                                    .getColor(),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            productModel
                                                                    .oldPrice +
                                                                ' ' +
                                                                productModel
                                                                    .Currancy,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                        ],
                                                      )
                                                    : Text(
                                                        (parse(productModel.priceHtml
                                                                            .toString()
                                                                            .trim())
                                                                        .body
                                                                        .text
                                                                        .trim()
                                                                        .length >
                                                                    0 ||
                                                                productModel
                                                                        .price
                                                                        .toString()
                                                                        .trim() ==
                                                                    '')
                                                            ? parse(productModel
                                                                    .priceHtml
                                                                    .toString()
                                                                    .trim())
                                                                .body
                                                                .text
                                                                .trim()
                                                            : "Best",
                                                        style: TextStyle(
                                                            color: themeColor
                                                                .getColor(),
                                                            fontSize: 18),
                                                      )
                                              ],
                                            ),
                                            Text(
                                              productModel.stockStatus,
                                              style: TextStyle(
                                                  color: themeColor.getColor(),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 40,
                                              child: FloatingActionButton(
                                                  heroTag: false,
                                                  onPressed: () {
                                                    setState(() {
                                                      if (piece != 1) {
                                                        piece--;
                                                      }
                                                    });
                                                  },
                                                  backgroundColor:
                                                      themeColor.getColor(),
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 25,
                                                  )),
                                            ),
                                            Container(
                                              width: 23,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                              child: Text('$piece',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 20)),
                                            ),
                                            Container(
                                              height: 40,
                                              child: FloatingActionButton(
                                                  backgroundColor:
                                                      themeColor.getColor(),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (piece != 99) {
                                                        piece++;
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 25,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        product_variations != null
                                            ? product_variations.isNotEmpty
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      ProductListTitleBar(
                                                        themeColor: themeColor,
                                                        title: getTransrlate(
                                                            context,
                                                            'productVariation'),
                                                        isCountShow: false,
                                                      ),
                                                      Container(
                                                        height: ScreenUtil
                                                                .getHeight(
                                                                    context) /
                                                            15,
                                                        width:
                                                            ScreenUtil.getWidth(
                                                                context),
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                product_variations ==
                                                                        null
                                                                    ? 0
                                                                    : product_variations
                                                                        .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int position) {
                                                              return Container(
                                                                height: ScreenUtil
                                                                        .getHeight(
                                                                            context) /
                                                                    20,
                                                                width: ScreenUtil
                                                                        .getWidth(
                                                                            context) /
                                                                    4,
                                                                child: ListView
                                                                    .builder(
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemCount: product_variations[position].attributes ==
                                                                                null
                                                                            ? 0
                                                                            : product_variations[position]
                                                                                .attributes
                                                                                .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int pos) {
                                                                          bool
                                                                              isSelected =
                                                                              checkboxValueA == position;

                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                checkboxValueA = position;
                                                                                checkboxValueB = product_variations[position].id;
                                                                                productModel.priceHtml = product_variations[position].price + ' ' + productModel.Currancy;
                                                                                productModel.price = product_variations[position].price;
                                                                                idProduct = product_variations[position].id;
                                                                                vriationName = product_variations[position].attributes[pos].option;
                                                                              });
                                                                            },
                                                                            child:
                                                                                Card(
                                                                              shape: isSelected ? new RoundedRectangleBorder(side: new BorderSide(color: themeColor.getColor(), width: 2.0), borderRadius: BorderRadius.circular(4.0)) : new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(4.0)),
                                                                              elevation: 2.0,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8, right: 8),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    product_variations[position].attributes[pos].option,
                                                                                    style: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontSize: ScreenUtil.getHeight(context) / 35,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                    ],
                                                  )
                                                : Container()
                                            : Container(),
                                        Container(
                                          margin: EdgeInsets.only(top: 24),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
//                                        Container(
//                                          width: 140,
//                                          child: GFButton(
//                                            onPressed: () {
//                                              setState(() {
//                                                // isLiked = !isLiked;
//
//                                                themeColor.isLogin?
//                                                product_variations == null||product_variations.isEmpty?
//                                                {_save(context),Nav.route(context, ShoppingCartPage())}
//                                                    :checkboxValueA==null?
//                                                Scaffold.of(context)
//                                                    .showSnackBar(SnackBar(content: Text(getTransrlate(context, 'SelectVariations')))):
//                                                {_save(context),Nav.route(context, ShoppingCartPage())}:
//                                                showLogintDialog(getTransrlate(context, 'login'), getTransrlate(context, 'notlogin'),context);
//                                              });
//                                              Nav.route(
//                                                  context, ShoppingCartPage());
//                                            },
//                                            child: Text(getTransrlate(context, 'Buy'),
//                                                style: TextStyle(
//                                                    fontWeight:
//                                                        FontWeight.w400)),
//                                            shape: GFButtonShape.pills,
//                                            type: GFButtonType.solid,
//                                            color: themeColor.getColor(),
//                                          ),
//                                        ),
                                              Container(
                                                width: 150,
                                                child: GFButton(
                                                  onPressed: () {
                                                    //Nav.route(context, OrderPage());
                                                    setState(() {
                                                      // isLiked = !isLiked;

                                                      product_variations ==
                                                                  null ||
                                                              product_variations
                                                                  .isEmpty
                                                          ? _save(context)
                                                          : checkboxValueA ==
                                                                  null
                                                              ? Scaffold.of(
                                                                      context)
                                                                  .showSnackBar(SnackBar(
                                                                      content: Text(getTransrlate(
                                                                          context,
                                                                          'SelectVariations'))))
                                                              : _save(context);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.shopping_cart,
                                                    color:
                                                        themeColor.getColor(),
                                                    size: 16,
                                                  ),
                                                  child: Text(
                                                      getTransrlate(
                                                          context, 'ADDtoCart'),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  type: GFButtonType.outline2x,
                                                  textStyle: GoogleFonts.cairo(
                                                    color:
                                                        themeColor.getColor(),
                                                  ),
                                                  color: themeColor.getColor(),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    padding: AppTheme.padding.copyWith(top: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.2),
                                            blurRadius:
                                                6.0, // soften the shadow
                                            spreadRadius:
                                                0.0, //extend the shadow
                                            offset: Offset(
                                              0.0, // Move to right 10  horizontally
                                              1.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(26)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                  getTransrlate(
                                                      context, 'Reviews'),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          Color(0xFF5D6A78))),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              RatingBar(
                                                initialRating: double.parse(
                                                    productModel.averageRating),
                                                itemSize: 20.0,
                                                minRating: 1,
                                                ignoreGestures: true,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                tapOnlyMode: false,
                                                itemBuilder: (context, _) =>
                                                    Container(
                                                  height: 12,
                                                  child: SvgPicture.asset(
                                                    "assets/icons/ic_star.svg",
                                                    color:
                                                        themeColor.getColor(),
                                                    width: 9,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                  productModel.averageRating +
                                                      ' ' +
                                                      getTransrlate(
                                                          context, 'Reviews'),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          Color(0xFF5D6A78))),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                !themeColor.isLogin
                                                    ? 'https://p.kindpng.com/picc/s/207-2074624_white-gray-circle-avatar-png-transparent-png.png'
                                                    : photo == null
                                                        ? 's'
                                                        : photo,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(name == null ? ' ' : name,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF5D6A78))),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    !themeColor.isLogin
                                                        ? showLogintDialog(
                                                            '', '', context)
                                                        : _displayDialog(
                                                            context,
                                                            themeColor);
                                                  },
                                                  child: Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                            getTransrlate(
                                                                context,
                                                                'AddComment'),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Color(
                                                                    0xFF5D6A78))),
                                                        Container(
                                                          color: Colors.grey,
                                                          height: 0.7,
                                                          width: ScreenUtil
                                                                  .getWidth(
                                                                      context) /
                                                              1.5,
                                                        )
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: product_review == null
                                              ? 100
                                              : product_review.length *
                                                          110.toDouble() >=
                                                      400
                                                  ? 400
                                                  : product_review.length *
                                                      110.toDouble(),
                                          child: ListView.builder(
                                              physics:
                                                  new NeverScrollableScrollPhysics(),
                                              itemCount: product_review == null
                                                  ? 0
                                                  : product_review.length >= 5
                                                      ? 4
                                                      : product_review.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int position) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  padding: EdgeInsets.all(12),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFffffF3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Row(
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage(
                                                            product_review[position]
                                                                        .photoReview ==
                                                                    null
                                                                ? ' '
                                                                : product_review[
                                                                        position]
                                                                    .photoReview),
                                                      ),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          RatingBar(
                                                            initialRating:
                                                                product_review[
                                                                        position]
                                                                    .rating
                                                                    .toDouble(),
                                                            itemSize: 14.0,
                                                            minRating: 1,
                                                            ignoreGestures:
                                                                true,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Container(
                                                              height: 12,
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/icons/ic_star.svg",
                                                                color: themeColor
                                                                    .getColor(),
                                                                width: 9,
                                                              ),
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              print(rating);
                                                            },
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                              product_review[
                                                                      position]
                                                                  .reviewer,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Color(
                                                                      0xFF5D6A78))),
                                                          Text(
                                                              (product_review[position]
                                                                              .review
                                                                              .toString()
                                                                              .trim()
                                                                              .length >
                                                                          0 ||
                                                                      product_review[
                                                                                  position]
                                                                              .review
                                                                              .toString()
                                                                              .trim() ==
                                                                          '')
                                                                  ? parse(product_review[
                                                                              position]
                                                                          .review
                                                                          .toString()
                                                                          .trim())
                                                                      .body
                                                                      .text
                                                                      .trim()
                                                                  : "Best",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Color(
                                                                      0xFF5D6A78)))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            child: Text(
                                              getTransrlate(
                                                  context, 'SeeAllComments'),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: themeColor.getColor()),
                                            ),
                                            onTap: () {
                                              _navigateAndDisplaySelection(
                                                  context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    padding: AppTheme.padding.copyWith(),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.2),
                                            blurRadius:
                                                6.0, // soften the shadow
                                            spreadRadius:
                                                0.0, //extend the shadow
                                            offset: Offset(
                                              0.0, // Move to right 10  horizontally
                                              1.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(26)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        ProductList(
                                          themeColor: themeColor,
                                          product: productRelated,
                                          productListTitleBar:
                                              ProductListTitleBar(
                                            themeColor: themeColor,
                                            title: getTransrlate(
                                                context, 'ProductRelated'),
                                            isCountShow: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
          isloading
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black45,
                  child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor.color))))
              : Container()
        ],
      ),
    );
  }

  _displayDialog(BuildContext context, themeColor) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: RatingBar(
                initialRating: 5,
                itemSize: 22,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Container(
                  height: 12,
                  child: SvgPicture.asset(
                    "assets/icons/ic_star.svg",
                    color: themeColor.getColor(),
                    width: 9,
                  ),
                ),
                onRatingUpdate: (rating) {
                  rateing = rating;
                  print(rating);
                },
              ),
            ),
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: comment,
                decoration: InputDecoration(
                    hintText: getTransrlate(context, 'yourComment'),
                    hintStyle: TextStyle(),
                    focusColor: themeColor.getColor()),
                validator: (String value) {
                  if (value.isEmpty) {
                    return getTransrlate(context, 'avalidComment');
                  }
                  formKey.currentState.save();

                  return null;
                },
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  getTransrlate(context, 'cancel'),
                  style: TextStyle(color: textColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  getTransrlate(context, 'Comment'),
                  style: TextStyle(color: themeColor.getColor()),
                ),
                onPressed: () async {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    setState(() {
                      isloading = true;
                    });
                    form.save();
                    await ProductService.Createrating(
                        name,
                        email,
                        productModel.id,
                        rateing,
                        comment.text.isEmpty ? ' ' : comment.text);
                    comment.clear();
                    Navigator.pop(context);
                    setState(() {
                      isloading = false;
                    });
                  }
                },
              )
            ],
          );
        });
    ProductService.getReviewer(productModel.id).then((usersFromServer) {
      setState(() {
        product_review = usersFromServer;
      });
    });
  }

  void _save(BuildContext context) async {
    double myInt = await double.parse(productModel.price);
    myInt = num.parse(myInt.toStringAsFixed(2));
    cart = Cart(
        product_variations != null ? idProduct : await productModel.id,
        product_variations != null
            ? await productModel.name + ' - $vriationName'
            : await productModel.name,
        piece,
        myInt,
        DateFormat.yMMMd().format(DateTime.now()),
        await productModel.images[0].src,
        productModel.Currancy);
    print(cart.id);

    if (product_variations != null) {
      cart.idVariation = checkboxValueB;
    }
    int result;
    if (await helper.checkItem(cart.id) == true) {
      print(11111111111);
      result = await helper.insertCart(cart);
    } else {
      Cart c = await helper.updateCartCount(cart.id);
      cart.quantity = piece + c.quantity;
      print(cart.quantity);
      setState(() {
        piece == 1;
      });
      result = await helper.updateCart(cart);
    }
    if (result == 0) {
      // showAlertDialog(getTransrlate(context, 'sorry'), getTransrlate(context, 'notSavedcart'));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(getTransrlate(context, 'Savedcart')),
        backgroundColor: Provider.of<ThemeNotifier>(context).getColor(),
      ));
      countCart();
    }
  }

  void countCart() async {
    helper.getCount().then((value) {
      Provider.of<ThemeNotifier>(context).intcountCart(value);
    });
  }

  Future fetchUserId() async {
    id = await SharedPreferencesHelper.getUserId();
    name = await SharedPreferencesHelper.getname();
    photo = await SharedPreferencesHelper.getUserimage();
    email = await SharedPreferencesHelper.getEmail();
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    await showDialog(
        context: context,
        builder: (_) {
          return MyDialog(
              productModel.id, name, email, rateing, product_review);
        });

    ProductService.getReviewer(productModel.id).then((usersFromServer) {
      setState(() {
        product_review = usersFromServer;
      });
    });
  }

  bool onLikeButton() {
    FavoritecheckItem(productModel).then((value) => {
          setState(() {
            isliked = value;
          }),
          print(isliked)
        });
    return isliked;
  }

  bool onLikeTapped() {
    Favorite(productModel).then((value) => {
          setState(() {
            isliked = !value;
          })
        });

    return isliked;
  }
}
