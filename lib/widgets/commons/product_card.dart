import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/AddToCart.dart';
import 'package:shoppingapp/utils/dialogVeriation.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';

import '../../config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Nav.route(context, ProductDetailPage(product: product,));
          },
          child: Container(
            width: ScreenUtil.getWidth(context) / 2,
            margin: EdgeInsets.only(left: 16, top: 8, right: 12, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 2)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 170,
                    child: Stack(
                      children: <Widget>[
                        Container(
                            width: 300,
                            height: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: (product.images == null)
                                    ? 'http://arabimagefoundation.com/images/defaultImage.png'
                                    : product.images[0].src,
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            )),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            width: 140,
                            height: 20,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                product.categories[0].name,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: themeColor.getColor(),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 8,
                          child: Container(
                            height: 38,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: 204.0,
                    padding: EdgeInsets.only(left: 10, top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 2,
                          minFontSize: 11,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: <Widget>[
                            RatingBar(
                              ignoreGestures: true,
                              initialRating: double.parse(product.averageRating),
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
                              product.averageRating,
                              style: GoogleFonts.poppins(
                                  fontSize: 9, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      product.oldPrice,
                                      style: GoogleFonts.poppins(
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      product.price,
                                      style: GoogleFonts.poppins(
                                          color: themeColor.getColor(),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                if(product.variations.isEmpty) {
                                  save(product,product.id,product.name);
                                  countCart(context);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor: mainColor,
                                      content: Text(getTransrlate(context, 'Savedcart'))));
                                }
                                else{
                                   showDialog(
                                      context: context,
                                      builder: (_) {
                                        print(product.id);
                                    return DialogVreations(product:product);
                                  });

                                }

                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 8),
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
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/icons/ic_product_shopping_cart.svg",
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      getTransrlate(context, 'ADDtoCart'),
                                      style: GoogleFonts.poppins(
                                          color: Color(0xFF5D6A78),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            )

                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
