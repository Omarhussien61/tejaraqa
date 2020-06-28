import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/shape/gf_button_shape.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/product_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';
import 'package:shoppingapp/widgets/product_detail/slider_dot.dart';

import 'order_page.dart';

class ProductDetailPageAlternative extends StatefulWidget {
  @override
  _ProductDetailPageAlternativeState createState() =>
      _ProductDetailPageAlternativeState();
}

class _ProductDetailPageAlternativeState
    extends State<ProductDetailPageAlternative> {
  int _carouselCurrentPage = 0;
  bool isLiked = false;
  int piece = 1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    final themeColor = Provider.of<ThemeNotifier>(context);
    List<Widget> imageSliders = discountImageList
        .map((item) => Container(
              height: ScreenUtil.getHeight(context) / 1.3,
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          width: ScreenUtil.getWidth(context),
                          height: ScreenUtil.getHeight(context) / 1.3,
                          color: themeColor.getColor(),
                          child: Image.asset(item,
                              fit: BoxFit.cover, width: 220.0))),
                ],
              ),
            ))
        .toList();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
//            leading: IconButton(
//                icon: Icon(Icons.chevron_left),
//                onPressed: () {
//                  // Do something
//                }
//            ),
            expandedHeight: 240.0,
            brightness: Brightness.light,
            floating: false,
            pinned: true,
            forceElevated: false,
            elevation: 50,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('T-shirt Rainbow Mans',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
              background: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    autoPlay: false,
                    height: ScreenUtil.getHeight(context) / 1.8,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _carouselCurrentPage = index;
                      });
                    }),
              ),
            ),
          ),
          new SliverList(
              delegate: new SliverChildListDelegate([
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SliderDotProductDetail(current: _carouselCurrentPage),
                  Container(
                    margin: EdgeInsets.only(top: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("T-shirt Rainbow Mans",
                                style: GoogleFonts.poppins(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF5D6A78))),
                            Row(
                              children: <Widget>[
//                                            RatingBar(
//                                              initialRating: 3,
//                                              itemSize: 18.0,
//                                              minRating: 1,
//                                              direction: Axis.horizontal,
//                                              allowHalfRating: true,
//                                              itemCount: 5,
//                                              itemBuilder: (context, _) =>
//                                                  Container(
//                                                    height: 12,
//                                                    child: SvgPicture.asset(
//                                                      "assets/icons/ic_star.svg",
//                                                      color: themeColor.getColor(),
//                                                      width: 9,
//                                                    ),
//                                                  ),
//                                              onRatingUpdate: (rating) {
//                                                print(rating);
//                                              },
//                                            ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "(395)",
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
                              backgroundColor: themeColor.getColor(),
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
                      itemBuilder: (_, __) => _buildBox(color: Colors.orange),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: ExpandablePanel(
//                      hasIcon: true,
//                      iconColor: themeColor.getColor(),
//                      headerAlignment: ExpandablePanelHeaderAlignment.center,
//                      iconPlacement: ExpandablePanelIconPlacement.left,
                      header: Text(
                        "Show Details",
                        style: GoogleFonts.poppins(
                            color: themeColor.getColor(), fontSize: 12),
                      ),
                      expanded: Text(
                        "Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator. ",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Price: ",
                                style: GoogleFonts.poppins(
                                    color: themeColor.getColor(), fontSize: 18),
                              ),
                              Text(
                                "\$ 1250",
                                style: GoogleFonts.poppins(
                                    color: themeColor.getColor(), fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Last 26 items",
                            style: GoogleFonts.poppins(
                                color: themeColor.getColor(),
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Free Cargo",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Color(0xFF707070),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 24,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('$piece',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 16)),
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
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text("+",
                                      style: TextStyle(color: Colors.white)),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 140,
                          child: GFButton(
                            onPressed: () {
                              Nav.route(context, OrderPage());
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
                              setState(() {
                                Nav.route(context, OrderPage());
                                isLiked = !isLiked;
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
                        initialRating: 3,
                        itemSize: 16.0,
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
                          print(rating);
                        },
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "4.5",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w400),
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
                          initialRating: 3,
                          itemSize: 20.0,
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
                            print(rating);
                          },
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("You gave 4 points",
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
                        backgroundImage:
                            AssetImage("assets/images/category_image1.png"),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
//                                  _displayDialog(context, themeColor);
                            },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Text("Comment",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xFF5D6A78))),
                                  Container(
                                    color: Colors.grey,
                                    height: 0.7,
                                    width: ScreenUtil.getWidth(context) / 1.5,
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFFEEEEF3),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/category_image1.png"),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RatingBar(
                                  initialRating: 3,
                                  itemSize: 14.0,
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
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("John Doe",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF5D6A78))),
                                Text("Lorem ipsum dolor",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF5D6A78)))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFFEEEEF3),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/category_image1.png"),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RatingBar(
                                  initialRating: 3,
                                  itemSize: 14.0,
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
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("John Doe",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF5D6A78))),
                                Text("Lorem ipsum dolor.",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF5D6A78)))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFFEEEEF3),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/category_image1.png"),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RatingBar(
                                  initialRating: 3,
                                  itemSize: 14.0,
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
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("John Doe",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF5D6A78))),
                                Text("Lorem ipsum dolor",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF5D6A78)))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFFEEEEF3),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/category_image1.png"),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RatingBar(
                                  initialRating: 3,
                                  itemSize: 14.0,
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
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("John Doe",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF5D6A78))),
                                Text("Lorem ipsum dolor",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF5D6A78)))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
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
                    productListTitleBar: ProductListTitleBar(
                      themeColor: themeColor,
                      title: "Similar Products",
                      isCountShow: false,
                    ),
                  ),
                ],
              ),
            )
          ])),
        ],
      ),
    );
  }

  Widget _buildBox({Color color}) {
    return Container(
      child: Align(
          alignment: Alignment.center,
          child: Text(
            "Aqua Color",
            style: GoogleFonts.poppins(color: Color(0xFF5D6A78), fontSize: 10),
          )),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF5D6A78), width: 0.7),
          borderRadius: BorderRadius.circular(32)),
      margin: EdgeInsets.only(right: 12),
      width: 75,
    );
  }
}
