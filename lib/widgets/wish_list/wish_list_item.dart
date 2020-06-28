import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class WishListItem extends StatelessWidget {
  const WishListItem({
    Key key,
    @required this.themeColor,
    this.imageUrl,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 8, left: 24, bottom: 8, right: 24),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/$imageUrl",
                      fit: BoxFit.cover,
                      width: ScreenUtil.getWidth(context) * 0.30,
                    )),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 160,
                padding: EdgeInsets.all(10),
              ),
              Container(
                width: ScreenUtil.getWidth(context) / 2,
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                          "\$120",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "\$478",
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
                      margin: EdgeInsets.only(top: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FindDropdown(
                            items: [
                              "1 piece",
                              "2 pieces",
                              "3 pieces",
                              "4 pieces"
                            ],
                            onChanged: (String item) => print(item),
                            selectedItem: "1 piece",
                            isUnderLine: false,
                          ),
                          Container(
                            height: 32,
                            margin: EdgeInsets.only(left: 14),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.2),
                                    blurRadius: 6.0,
                                    // soften the shadow
                                    spreadRadius: 0.0,
                                    //extend the shadow
                                    offset: Offset(
                                      0.0,
                                      // Move to right 10  horizontally
                                      1.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ]),
                            child: GFButton(
                              onPressed: () {
                                Nav.route(context, ShoppingCartPage());
                              },
                              icon: LikeButton(
                                size: 10,
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
                              child: Text(
                                "Add to Cart",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF5D6A78),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                              type: GFButtonType.transparent,
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
          top: 16,
          right: 32,
          child: Icon(
            Icons.more_vert,
            color: Colors.grey,
            size: 18,
          ),
        )
      ],
    );
  }
}
