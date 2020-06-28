import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';

import '../../config.dart';

class DiscountItem extends StatelessWidget {
  final themeColor;
  final String imageUrl;

  DiscountItem({Key key, this.themeColor, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.route(context, ProductDetailPage());
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8, left: 16, bottom: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 5.0,
                      spreadRadius: 1,
                      offset: Offset(0.0, 1)),
                ]),
            width: ScreenUtil.getWidth(context) / 1.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/$imageUrl",
                        fit: BoxFit.cover,
                      )),
                  width: ScreenUtil.getWidth(context) * 0.30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 160,
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AutoSizeText(
                        'T-shirt Rainbow UFO Mens',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Color(0xFF5D6A78),
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 2,
                        minFontSize: 11,
                      ),
                      Row(
                        children: <Widget>[
                          RatingBar(
                            ignoreGestures: true,
                            initialRating: 3,
                            itemSize: 14.0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Ionicons.ios_star,
                              color: themeColor.getColor(),
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "(395)",
                            style: GoogleFonts.poppins(
                                fontSize: 9, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "\$473",
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "\$89",
                            style: GoogleFonts.poppins(
                                color: themeColor.getColor(),
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Text(
                        "Free Cargo",
                        style: GoogleFonts.poppins(
                            color: themeColor.getColor(),
                            fontSize: 10,
                            fontWeight: FontWeight.w300),
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3),
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
                                  ]),
                              child: LikeButton(
                                size: 12,
                                circleColor: CircleColor(
                                    start: themeColor.getColor(),
                                    end: themeColor.getColor()),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: themeColor.getColor(),
                                  dotSecondaryColor: themeColor.getColor(),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: isLiked
                                        ? themeColor.getColor()
                                        : textColor,
                                    size: 12,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 8,
            child: Container(
              child: GFButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: mainColor,
                      content: Text('Product added to cart')));
                  Nav.route(context, ShoppingCartPage());
                },
                icon: SvgPicture.asset(
                  "assets/icons/ic_product_shopping_cart.svg",
                  height: 12,
                ),
                child: Text(
                  "Add to Cart",
                  style: GoogleFonts.poppins(
                      color: Color(0xFF5D6A78),
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
                type: GFButtonType.transparent,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
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
                  ]),
              height: 32,
              margin: EdgeInsets.only(right: 2),
            ),
          )
        ],
      ),
    );
  }
}
