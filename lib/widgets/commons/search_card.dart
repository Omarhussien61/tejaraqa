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

class SearchCard extends StatefulWidget {
  const SearchCard({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final ProductModel product;

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
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
        InkWell(
          onTap: () {
            Nav.route(
                context,
                ProductDetailPage(
                  product: widget.product,
                ));
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
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                            width: 300,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: (widget.product.images == null||widget.product.images.isEmpty)
                                    ? 'http://arabimagefoundation.com/images/defaultImage.png'
                                    : widget.product.images[0].src,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10,top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          widget.product.name,
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          minFontSize: 11,
                        ),
                        SizedBox(
                          height: 2,
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
                              width: 8,
                            ),
                            Text(
                              widget.product.averageRating,
                              style: GoogleFonts.cairo(
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
                                    style: GoogleFonts.cairo(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  AutoSizeText(
                                    widget.product.price+' '+widget.product.Currancy,
                                   minFontSize: 11,
                                    maxFontSize: 13,
                                    style: GoogleFonts.cairo(
                                        color: widget.themeColor.getColor(),
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
                                maxLines: 1,
                                style: GoogleFonts.cairo(
                                    color: widget.themeColor.getColor(),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                        InkWell(
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
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/icons/ic_product_shopping_cart.svg",
                                height: 12,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 15,
          child: Container(
            height: 38,
            width: 32,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: InkWell(
                onTap: () {
                  onLikeTapped();
                },
                child: Icon(
                  isliked != null
                      ? !isliked ? Icons.favorite : Icons.favorite_border
                      : Icons.favorite_border,
                  color: widget.themeColor.getColor(),
                )),
          ),
        )
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
