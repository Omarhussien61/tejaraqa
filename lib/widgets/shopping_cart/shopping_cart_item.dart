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
    return Row(
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
