import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Favorite.dart';
import 'package:shoppingapp/pages/product_detail_By_id.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class WishListItem extends StatelessWidget {

  const WishListItem({
    Key key,
    @required this.favoriteModel,
  }) : super(key: key);

  final FavoriteModel favoriteModel;

  @override
  Widget build(BuildContext context) {
   var themeColor = Provider.of<ThemeNotifier>(context);
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: (){
            Nav.route(context, ProductDetailPage_id(product: favoriteModel.id));
          },
          child: Container(
            margin: EdgeInsets.only(top: 8, left: 22, bottom: 8, right: 22),
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
                      child:CachedNetworkImage(
                        imageUrl: favoriteModel.image,
                      )),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 130,
                  width: 150,
                  padding: EdgeInsets.all(8),
                ),
                Container(
                  width: ScreenUtil.getWidth(context) / 2.5,
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AutoSizeText(
                        favoriteModel.name,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Color(0xFF5D6A78),
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 2,
                        minFontSize: 11,
                      ),
                      Text(
                        favoriteModel.price.toString(),
                        style: GoogleFonts.poppins(
                            color: themeColor.getColor(),
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        favoriteModel.category,
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
        ),
      ],
    );
  }
}
