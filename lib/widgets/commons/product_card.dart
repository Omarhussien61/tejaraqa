import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/add_favorite.dart';
import 'package:shoppingapp/utils/commons/add_to_cart.dart';
import 'package:shoppingapp/utils/commons/show_dialog.dart';
import 'package:shoppingapp/utils/dialogVeriation.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';

import '../../config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final ProductModel product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isliked;

  @override
  void initState() {
    onLikeButton();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil.getWidth(context) / 2,
          margin: EdgeInsets.only(left: 16, top: 8, right: 12, bottom: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child:InkWell(
            onTap: () {
              Nav.route(
                  context,
                  ProductDetailPage(
                    product: widget.product,
                  ));
            },
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
                    height: 150,
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
                                imageUrl: (widget.product.images == null)
                                    ? 'http://arabimagefoundation.com/images/defaultImage.png'
                                    : widget.product.images[0].src,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                                widget.product.categories[0].name,
                                maxLines: 1,
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  color: widget.themeColor.getColor(),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 8,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 38,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8))),
                              child: InkWell(
                                  onTap: () {
                                    onLikeTapped();
                                  },
                                  child: Icon(
                                    isliked != null
                                        ? !isliked
                                            ? Icons.favorite
                                            : Icons.favorite_border
                                        : Icons.favorite_border,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width:ScreenUtil.getWidth(context)/2.1,
                    padding: EdgeInsets.only(left: 10, top: 2,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          widget.product.name,
                          maxLines: 1,
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          minFontSize: 11,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          children: <Widget>[
                            RatingBar(
                              ignoreGestures: true,
                              initialRating:
                                  double.parse(widget.product.averageRating),
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
                              width: 6,
                            ),
                            Text(
                              widget.product.averageRating,
                              style: GoogleFonts.cairo(
                                  fontSize: 9, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            widget.product.variations.isEmpty
                                ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  widget.product.oldPrice+' ',
                                  maxLines: 1,

                                  style: GoogleFonts.cairo(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  widget.product.price+' '+widget.product.Currancy,
                                  maxLines: 1,

                                  style: GoogleFonts.cairo(
                                      color: widget.themeColor.getColor(),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                                : AutoSizeText(
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
                              maxLines: 1,
                              minFontSize: 10,
                              maxFontSize: 14,
                              style: GoogleFonts.cairo(
                                  color: widget.themeColor.getColor(),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              width:ScreenUtil.getWidth(context)/2.8,
                              child: InkWell(
                                onTap: () {
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
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 8, left: 8, bottom: 10, right: 8),
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
                                        style: GoogleFonts.cairo(
                                            color: Color(0xFF5D6A78),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
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
  bool onLikeButton() {
    FavoritecheckItem(widget.product).then((value) => {
          setState(() {
            isliked = value;
          }),
          print(isliked)
        });
    return isliked;
  }
  bool onLikeTapped() {
    Favorite(widget.product).then((value) => {
      setState(() {
        isliked = !value;
      })
    });


    return isliked;
  }
}
