
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/modal/Product_review.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/product_detail_By_id.dart';
import 'package:shoppingapp/pages/search_page.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
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
  bool isLiked = false;
  List<Product_review> product_review;
  int piece = 1;
  String Photo='  ';
@override
  void initState() {
  SharedPreferences.getInstance().then((prefs){
    setState(() {
      Photo= prefs.getString('image_url');
    });
    ProductService.getReviewerEmail(prefs.getString('user_email')).then((value){
      setState(() {
        product_review=value;
      });
    });
  });

    super.initState();
  }
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42.0), // here the desired height
        child: AppBar(
          backgroundColor: greyBackground,
          elevation: 0,
          centerTitle: true,
          title: Text(
            getTransrlate(context, 'productRateing'),
            style:
            GoogleFonts.cairo(color: Color(0xFF5D6A78), fontSize: 15),
          ),
          leading: InkWell(
            onTap:() {
              Navigator.pop(context);},
            child: Icon(
              Icons.chevron_left,
              color: textColor,
              size: 32,
            ),
          ),
        ),
      ),

      body:    product_review!=null?product_review.isEmpty?Center(
        child: Hero(
          tag: 'icon',
          child: Column(
            children: [

              Container(
                height: 400,
                child: CachedNetworkImage(
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageUrl:
                    'https://d2.woo2.app/wp-content/uploads/2020/08/1-removebg-preview-1.png'),
              ),
              Text( getTransrlate(context, 'noProductratings')),
              SizedBox(
                height: 50,
              ),
              GFButton(
                onPressed: (){
                  Nav.route(context, SearchPage());
                },
                text: getTransrlate(context, 'Browse'),
                color: themeColor.getColor(),
                textStyle: GoogleFonts.cairo(
                    fontSize: 18
                ),
              )
            ],
          ),
        ),
      ): Container(
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
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(getTransrlate(context, 'Reviews'),
                      style: GoogleFonts.cairo(
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
                    tapOnlyMode: false,
                    itemBuilder: (context, _) => Container(
                      height: 12,
                      child: SvgPicture.asset(
                        "assets/icons/ic_star.svg",
                        color: themeColor.getColor(),
                        width: 9,
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            product_review!=null?Container(
              height: ScreenUtil.getHeight(context)-188,
              child: ListView.builder(
                  itemCount:  product_review==null?0:product_review.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFFEEEEF3),
                          borderRadius:
                          BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: (){
                          Nav.route(context, ProductDetailPage_id(product: product_review[position].productId));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      Photo),
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
                                        style: GoogleFonts.cairo(
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
                                        style: GoogleFonts.cairo(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF5D6A78)))
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(
                              width: 30,
                            ),
                            Icon(Feather.chevrons_left,color: Colors.grey,)
                          ],
                        ),
                      ),
                    );
                  }),
            ):
            Center(child:
            CircularProgressIndicator(
                valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))),

          ],
        ),
      ):  Center(child:
      CircularProgressIndicator(
          valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))),
    );
  }

}
