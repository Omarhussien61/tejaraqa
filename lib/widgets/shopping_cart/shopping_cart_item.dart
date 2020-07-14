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
import 'package:shoppingapp/utils/util/sql_helper.dart';

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    Key key,
    @required this.themeColor,
    @required this.productModel,
  }) : super(key: key);
  final Cart productModel;
  final ThemeNotifier themeColor;

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
      ],
    );
  }
  void delete(BuildContext context, Cart student) async {
    SQL_Helper helper = new SQL_Helper();

    int ressult = await helper.deleteCart(student.id);
    if (ressult != 0) {
      //updateListView();
    }
  }

}
