import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/home_navigator.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/add_favorite.dart';
import 'package:shoppingapp/utils/commons/add_to_cart.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/commons/show_dialog.dart';
import 'package:shoppingapp/utils/dialogVeriation.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';

import '../../config.dart';
class DiscountItem extends StatefulWidget {
  final ProductModel product;
  final themeColor;

  DiscountItem({Key key, this.themeColor, this.product}) : super(key: key);
  @override
  _DiscountItemState createState() => _DiscountItemState();
}

class _DiscountItemState extends State<DiscountItem> {

  SQL_Helper helper = new SQL_Helper();
  bool isliked;


  @override
  void initState() {
    onLikeButton();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Nav.route(context, ProductDetailPage(product: widget.product,));
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8, left: 16, bottom: 8,right: 8),
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
                      child: CachedNetworkImage(
                        imageUrl: (widget.product.images == null)
                            ? 'http://arabimagefoundation.com/images/defaultImage.png'
                            : widget.product.images[0].src,
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
                      Container(
                        width: 180,
                        child: AutoSizeText(
                          widget.product.name,
                          maxFontSize: 15,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 2,
                          minFontSize: 11,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          RatingBar(
                            ignoreGestures: true,
                            initialRating: double.parse(widget.product.averageRating),
                            itemSize: 14.0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Ionicons.ios_star,
                              color: widget.themeColor.getColor(),
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
                                fontSize: 9, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      widget.product.variations.isEmpty
                          ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.product.oldPrice+' ',
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            widget.product.price+' '+widget.product.Currancy,
                            style: GoogleFonts.poppins(
                                color: widget.themeColor.getColor(),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                          : Text(
                        (parse(widget.product.priceHtml
                            .toString()
                            .trim())
                            .body
                            .text
                            .trim()
                            .length >
                            0 ||
                            widget.product.price
                                .toString()
                                .trim() ==
                                '')
                            ? parse(widget.product.priceHtml
                            .toString()
                            .trim())
                            .body
                            .text
                            .trim()
                            : "Best",
                        style: GoogleFonts.poppins(
                            color: widget.themeColor.getColor(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        width: 180,
                        child: Text(
                          (parse(widget.product.sortDescription.toString().trim())
                              .body
                              .text
                              .trim()
                              .length >
                              0 ||
                              widget.product.sortDescription.toString().trim() ==
                                  '')
                              ? parse(widget.product.sortDescription.toString().trim())
                              .body
                              .text
                              .trim()
                              : "Best",
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                              color: widget.themeColor.getColor(),
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
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
                          child: InkWell(
                              onTap: (){
                                onLikeTapped();
                              },child:
                          Icon(
                            isliked!=null?!isliked?Icons.favorite:Icons.favorite_border:Icons.favorite_border,
                          color: widget.themeColor.getColor(),)
                          )
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
                  if(!Provider.of<ThemeNotifier>(context).isLogin)
                    showLogintDialog(getTransrlate(context, 'login'), getTransrlate(context, 'notlogin'),context);
                  else{
                    if (widget.product.variations.isEmpty) {
                      save(
                          widget.product,
                          widget.product.id,
                          widget.product.name,
                          widget.product.price,
                          context);
                      countCart(context);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: mainColor,
                          content: Text(getTransrlate(
                              context, 'Savedcart'))));
                    }
                    else {
                      showDialog(
                          context: context,
                          builder: (_) {
                            print(widget.product.id);
                            return DialogVreations(
                                product: widget.product,
                            ctx: context,);
                          });
                    }
                  }

                },
                icon: SvgPicture.asset(
                  "assets/icons/ic_product_shopping_cart.svg",
                  height: 12,
                ),
                child: Text(
                  getTransrlate(context, 'ADDtoCart'),
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
  bool onLikeButton() {
    FavoritecheckItem(widget.product).then((value) => {
        setState(() {
        isliked=value;
      }),
      print(isliked)
    });
    return isliked;

  }

  bool onLikeTapped() {

    Provider.of<ThemeNotifier>(context).isLogin?
    Favorite(widget.product).then((value) => {
      setState(() {
        isliked = !value;
      })
    }):showLogintDialog(getTransrlate(context, 'login'), getTransrlate(context, 'notlogin'),context);


    return isliked;
}

}
