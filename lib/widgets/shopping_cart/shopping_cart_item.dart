import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
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
                      'Sunt planetaes aperto mirabilis,',
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
                          "\$89",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "\$259",
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
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 12,
          child: IconButton(
            icon: Icon(
              Feather.trash,
              size: 18,
              color: Color(0xFF5D6A78),
            ),
            onPressed: () {},
          ),
        ),
        Positioned(
          bottom: 24,
          right: 32,
          child: Container(
            width: 48,
            margin: EdgeInsets.only(top: 26),
            child: Align(
              alignment: Alignment.centerRight,
              child: FindDropdown(
                items: ["1", "2", "3", "4"],
                onChanged: (String item) => print(item),
                selectedItem: "1",
                isUnderLine: false,
              ),
            ),
          ),
        )
      ],
    );
  }
}
