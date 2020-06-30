import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    Key key,
    @required this.themeColor,
    @required this.productModel,
    this.imageUrl,
  }) : super(key: key);
  final Cart productModel;
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
                    child: CachedNetworkImage(
                      imageUrl: (productModel.image == null)
                          ? 'http://arabimagefoundation.com/images/defaultImage.png'
                          : productModel.image,
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
                      productModel.name,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Color(0xFF5D6A78),
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      minFontSize: 11,
                    ),
                    Text(
                      productModel.pass.toString(),
                      style: GoogleFonts.poppins(
                          color: themeColor.getColor(),
                          fontSize: 18,
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
            width: 100,
            margin: EdgeInsets.only(top: 26),
            child: Align(
              alignment: Alignment.centerRight,
              child:  Container(
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

                            if (productModel.quantity != 0) {
                              productModel.quantity--;
                            }

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
                          child: Text(productModel.quantity.toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16)),
                        )),
                    InkWell(
                        onTap: () {

                            if (productModel.quantity != 9) {
                              productModel.quantity++;
                            }
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
              ),
            ),
          ),
        )
      ],
    );
  }
}
