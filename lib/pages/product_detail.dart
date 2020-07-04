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
import 'package:shoppingapp/Provider/counter.dart';
import 'package:shoppingapp/modal/Product_review.dart';
import 'package:shoppingapp/modal/Product_variations.dart';
import 'package:shoppingapp/modal/Recentview.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/order_page.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/utils/util/recentId.dart';
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

class ProductDetailPage extends StatefulWidget {
    ProductDetailPage({Key key,
      @required this.product,
    }) : super(key: key);
    final ProductModel product;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  SQL_Helper helper = new SQL_Helper();
  SQL_Rercent helperRecent = new SQL_Rercent();
  Recentview recentview;
  Cart cart;
  int checkboxValueA,checkboxValueB ;
  List<Product_variations> product_variations;
  Animation<double> animation;
  Future<List<ProductModel>> productRelated;
  int _carouselCurrentPage = 0;
  ScrollController tempScroll = ScrollController();
  double radius = 40;
  int piece = 1;
  static int count =0;
  List<Product_review> product_review=new  List<Product_review>();
  @override
  void initState() {
    countCart();
    tempScroll = ScrollController()
      ..addListener(() {
        setState(() {
          print(tempScroll.position.viewportDimension);
        });
      });
    productRelated=ProductService.getRelatedProducts(widget.product.related_ids.toString());
    ProductService.getReviewer(widget.product.id).then((usersFromServer) {
      setState(() {
        product_review = usersFromServer;
      });
    });
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
    _addtoRecentview();
  }
  void _addtoRecentview() async {
    recentview=new Recentview(widget.product.id, count++);
    int result;
    if (await helperRecent.checkItem(recentview.id) == true) {
      result =  await helperRecent.insertRecentView(recentview);
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

  Widget _buildBox({Color color,String name}) {
    return Container(
      child: Align(
          alignment: Alignment.center,
          child: Text(
            name,
            maxLines: 1,
            style: GoogleFonts.poppins(color: Color(0xFF5D6A78), fontSize: 10),
          )),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF5D6A78), width: 0.7),
          borderRadius: BorderRadius.circular(32)),
      margin: EdgeInsets.only(right: 12),
      width: 75,
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
    List<Widget> imageSliders = widget.product.images
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
                          color: themeColor.getColor(),
                          child: CachedNetworkImage(
                            imageUrl: (widget.product.images == null)
                                ? 'http://arabimagefoundation.com/images/defaultImage.png'
                                : item.src,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ))),
                ],
              ),
            ))
        .toList();
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: false,
                  height: ScreenUtil.getHeight(context) / 1.9,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _carouselCurrentPage = index;
                    });
                  }),
            ),
            Positioned(
              left: 9,
              top: 32,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    color: themeColor.getColor(),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 24,
              top: 24,
              child: Container(
                height: 42,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Badge(
                  animationDuration: Duration(milliseconds: 1500),
                  badgeColor: themeColor.getColor(),
                  alignment: Alignment(0, 0),
                  position: BadgePosition.bottomRight(),
                  padding: EdgeInsets.all(8),
                  badgeContent: Text(
                    Provider.of<counter>(context).countCart.toString(),
                    style: TextStyle(color: whiteColor, fontSize: 10),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/ic_shopping_cart.svg",
                    color: Colors.white,
                    height: 26,
                  ),
                ),
              ),
            ),

//            Positioned(
//              right: 48,
//              top: ScreenUtil.getHeight(context) / 2.40,
//              child: FloatingActionButton(
//                onPressed: () {},
//                backgroundColor: LightColor.orange,
//                child: Icon(Icons.shopping_basket,
//                    color: Theme.of(context)
//                        .floatingActionButtonTheme
//                        .backgroundColor),
//              ),
//            ),
//            AnimatedPositioned(
//              duration: Duration(milliseconds: 400),
//              bottom: isLiked ? ScreenUtil.getHeight(context) - 74 : 45,
//              right: isLiked ? 14 : 25,
//              child: AnimatedOpacity(
//                duration: Duration(milliseconds: 1000),
//                opacity: isLiked ? 0.5 : 1,
//                child: Badge(
//                  animationDuration: Duration(milliseconds: 1500),
//                  badgeColor: themeColor.getColor(),
//                  alignment: Alignment(0, 0),
//                  position: BadgePosition.bottomRight(),
//                  padding: EdgeInsets.all(8),
//                  badgeContent: Text(
//                    isLiked ? '4' : '5',
//                    style: TextStyle(color: whiteColor, fontSize: 10),
//                  ),
//
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: 45,
//              right: 12,
//              child: FloatingActionButton(
//                onPressed: () {
//                  setState(() {
//                    isLiked = !isLiked;
//                  });
//                },
//                backgroundColor: LightColor.orange,
//                child: Icon(Icons.shopping_basket,
//                    color: Theme.of(context)
//                        .floatingActionButtonTheme
//                        .backgroundColor),
//              ),
//            )
            DraggableScrollableSheet(
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
                            topLeft: Radius.circular(
                                scrollController.position.viewportDimension >
                                        660
                                    ? 0
                                    : 26),
                            topRight: Radius.circular(
                                scrollController.position.viewportDimension >
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
                                  blurRadius: 6.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(26)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SliderDotProductDetail(
                                  current: _carouselCurrentPage),
                              Container(
                                margin: EdgeInsets.only(top: 14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(widget.product.name,
                                            style: GoogleFonts.poppins(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF5D6A78))),
                                        Row(
                                          children: <Widget>[
                                            RatingBar(
                                              initialRating: double.parse(widget.product.averageRating),
                                              itemSize: 18.0,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemBuilder: (context, _) =>
                                                  Container(
                                                height: 12,
                                                child: SvgPicture.asset(
                                                  "assets/icons/ic_star.svg",
                                                  color: themeColor.getColor(),
                                                  width: 9,
                                                ),
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              widget.product.averageRating,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: 48,
                                        child: FloatingActionButton(
                                          heroTag: null,
                                          elevation: 0,
                                          onPressed: () {
                                            setState(() {
                                              isLiked = !isLiked;
                                            });
                                          },
                                          backgroundColor:
                                              themeColor.getColor(),
                                          child: Icon(Icons.favorite,
                                              color: Theme.of(context)
                                                  .floatingActionButtonTheme
                                                  .backgroundColor),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 12),
                                height: 24,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.product.categories.length,
                                  itemBuilder: (_, i) =>
                                      _buildBox(color: Colors.orange,name: widget.product.categories[i].name),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: ExpandablePanel(
//                                  hasIcon: true,
//                                  iconColor: themeColor.getColor(),
//                                  headerAlignment:
//                                  ExpandablePanelHeaderAlignment.center,
//                                  iconPlacement:
//                                  ExpandablePanelIconPlacement.left,
                                  header: Text(
                                    "Show All",
                                    style: GoogleFonts.poppins(
                                        color: themeColor.getColor(),
                                        fontSize: 12),
                                  ),
                                  expanded: Text(
                                    widget.product.description   ,
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF5D6A78),
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Price: ",
                                            style: GoogleFonts.poppins(
                                                color: themeColor.getColor(),
                                                fontSize: 18),
                                          ),
                                          Text(
                                            widget.product.price,
                                            style: GoogleFonts.poppins(
                                                color: themeColor.getColor(),
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        widget.product.stockStatus,
                                        style: GoogleFonts.poppins(
                                            color: themeColor.getColor(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        widget.product.categories[0].name,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF5D6A78),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: themeColor.getColor(),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (piece != 0) {
                                                  piece--;
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Text(
                                                "-",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white),
                                              ),
                                            )),
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(18),
                                              color: Color(0xFF707070),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 24,
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text('$piece',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (piece != 9) {
                                                  piece++;
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text("+",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 24),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 140,
                                      child: GFButton(
                                        onPressed: () {
                                          Nav.route(context, ShoppingCartPage());
                                        },
                                        child: Text("Buy",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400)),
                                        shape: GFButtonShape.pills,
                                        type: GFButtonType.solid,
                                        color: themeColor.getColor(),
                                      ),
                                    ),
                                    Container(
                                      width: 140,
                                      child: GFButton(
                                        onPressed: () {
                                          //Nav.route(context, OrderPage());
                                          setState(() {
                                           // isLiked = !isLiked;
                                            _save();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.shopping_cart,
                                          color: themeColor.getColor(),
                                          size: 16,
                                        ),
                                        child: Text("Add to Cart",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400)),
                                        type: GFButtonType.outline2x,
                                        shape: GFButtonShape.pills,
                                        color: themeColor.getColor(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GFButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.notifications,
                                      color: Color(0xFFB3C0C8),
                                      size: 16,
                                    ),
                                    child: Text("Add to Cart",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400)),
                                    type: GFButtonType.transparent,
                                    shape: GFButtonShape.pills,
                                    color: Color(0xFFB3C0C8),
                                  ),
                                  GFButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      color: Color(0xFFB3C0C8),
                                      size: 16,
                                    ),
                                    child: Text("Share",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400)),
                                    type: GFButtonType.transparent,
                                    shape: GFButtonShape.pills,
                                    color: Color(0xFFB3C0C8),
                                  )
                                ],
                              )
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
                                  blurRadius: 6.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(26)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  RatingBar(
                                    initialRating: double.parse(widget.product.averageRating),
                                    itemSize: 16.0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) =>
                                        Container(
                                          height: 12,
                                          child: SvgPicture.asset(
                                            "assets/icons/ic_star.svg",
                                            color: themeColor.getColor(),
                                            width: 9,
                                          ),
                                        ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    widget.product.averageRating,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: <Widget>[
                                    Text("Rate",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF5D6A78))),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    RatingBar(
                                      initialRating: double.parse(widget.product.averageRating),
                                      itemSize: 20.0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemBuilder: (context, _) =>
                                          Container(
                                            height: 12,
                                            child: SvgPicture.asset(
                                              "assets/icons/ic_star.svg",
                                              color: themeColor.getColor(),
                                              width: 9,
                                            ),
                                          ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text( widget.product.averageRating+" star",
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF5D6A78))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/category_image1.png"),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("John Doe",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF5D6A78))),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _displayDialog(context, themeColor);
                                        },
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text("Add Comment",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w300,
                                                      color:
                                                      Color(0xFF5D6A78))),
                                              Container(
                                                color: Colors.grey,
                                                height: 0.7,
                                                width: ScreenUtil.getWidth(
                                                    context) /
                                                    1.5,
                                              )
                                            ],
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                height: product_review == null ? 100 : product_review.length*110.toDouble(),
                                child: ListView.builder(
                                    physics: new NeverScrollableScrollPhysics(),
                                    itemCount:  product_review == null ? 0 : product_review.length,
                                    itemBuilder: (BuildContext context, int position) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(vertical: 5),
                                        padding: EdgeInsets.all(12),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFEEEEF3),
                                            borderRadius:
                                            BorderRadius.circular(12)),
                                        child: Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  product_review[0].reviewer),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                RatingBar(
                                                  initialRating: product_review[position].rating.toDouble(),
                                                  itemSize: 14.0,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      Container(
                                                        height: 12,
                                                        child: SvgPicture.asset(
                                                          "assets/icons/ic_star.svg",
                                                          color: themeColor
                                                              .getColor(),
                                                          width: 9,
                                                        ),
                                                      ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(product_review[0].reviewer,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w300,
                                                        color: Color(0xFF5D6A78))),
                                                Text(
                                                    ( product_review[position].review
                                                        .toString()
                                                        .trim()
                                                        .length >
                                                        0 ||
                                                        product_review[position].review
                                                            .toString()
                                                            .trim() ==
                                                            '') ? parse( product_review[position].review
                                                        .toString()
                                                        .trim())
                                                        .body
                                                        .text
                                                        .trim()
                                                        : "Best",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w300,
                                                        color: Color(0xFF5D6A78)))
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "See All Comments",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: themeColor.getColor()),
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
                                  blurRadius: 6.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(26)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              ProductList(
                                themeColor: themeColor,
                                product: productRelated,
                                productListTitleBar: ProductListTitleBar(
                                  themeColor: themeColor,
                                  title: "Similar Products",
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
    );
  }

  _displayDialog(BuildContext context, themeColor) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Comment'),
            content: TextField(
//              controller: _textFieldController,
              decoration: InputDecoration(
                  hintText: "Your Comment",
                  hintStyle: GoogleFonts.poppins(),
                  focusColor: themeColor.getColor()),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  'CANCEL',
                  style: GoogleFonts.poppins(color: textColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  'COMMENT',
                  style: GoogleFonts.poppins(color: themeColor.getColor()),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _save() async {
    double myInt = await double.parse(widget.product.price);
    myInt=num.parse(myInt.toStringAsFixed(2));
    cart= new Cart(await widget.product.id, await widget.product.name, piece, myInt,
        DateFormat.yMMMd().format(DateTime.now()),await widget.product.images[0].src);
    if(product_variations!=null){cart.idVariation=checkboxValueB;}
    int result;
    if (await helper.checkItem(cart.id) == true) {
      result =  await helper.insertCart(cart);
    } else {
      result = await helper.updateCart(cart);
    }
    if (result == 0) {
     // showAlertDialog(getTransrlate(context, 'sorry'), getTransrlate(context, 'notSavedcart'));
    } else {
     // showAlertDialog(getTransrlate(context, 'Alert'),getTransrlate(context, 'Savedcart'));
      print('doneeeeeeeeeeeeeeeeeeeeeeeee');
      countCart();
    }
  }
  void countCart() async {
    helper.getCount().then((value) {
      Provider.of<counter>(context).intcountCart(value);

    });

  }

}
