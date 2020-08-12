
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoppingapp/modal/Product_review.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';

class MyDialog extends StatefulWidget {
  int id;
  String name,email;
  double rateing;
  List<Product_review> product_review;
  MyDialog(this.id, this.name, this.email, this.rateing,this.product_review);
  @override
  _MyDialogState createState() => new _MyDialogState(id,name,email,rateing,product_review);
}
class _MyDialogState extends State<MyDialog> {
  int id;
  String name,email;
  String comment;

  List<Product_review> product_review;
  _MyDialogState(this.id, this.name, this.email, this.rateing,this.product_review);
  final formKey = GlobalKey<FormState>();
  double rateing;
  bool isloading=false;
  double deviceHeight,deviceWidth;
  @override
  Widget build(BuildContext context) {
    final bloc=Provider.of<ThemeNotifier>(context);
    deviceHeight=MediaQuery.of(context).size.height;
    deviceWidth=MediaQuery.of(context).size.width;
    return  Stack(
      children: <Widget>[
        AlertDialog(
          content:Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: deviceWidth,
                    height: deviceHeight/3,
                    child: ListView.builder(
                        itemCount:  product_review == null ? 0 : product_review.length,
                        itemBuilder: (BuildContext context, int position) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  product_review[position].reviewer,
                                  style: TextStyle(
                                    fontFamily: 'El_Messiri',
                                  ),
                                ),
                                RatingBar(
                                  initialRating: double.parse(product_review[position].rating.toString()),
                                  itemSize: 14.0,
                                  minRating: 1,
                                  direction:
                                  Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder:
                                      (context, _) =>
                                      Container(
                                        height: 12,
                                        child: SvgPicture.asset(
                                          "assets/icons/ic_star.svg",
                                          color: bloc
                                              .getColor(),
                                          width: 9,
                                        ),
                                      ),
                                  onRatingUpdate: print,
                                ),

                              ],
                            ),
                            subtitle: Text(
                              ( product_review[position].review
                                  .toString()
                                  .trim()
                                  .length >
                                  0 ||
                                  product_review[position].review
                                      .toString()
                                      .trim() ==
                                      '') ? parse( product_review[position].review
                                  .toString()
                                  .trim())
                                  .body
                                  .text
                                  .trim()
                                  : "Best",
                              style: TextStyle(
                                fontFamily: 'El_Messiri',
                              ),
                            ),
                            dense: true,
                          );
                        }),
                  ),
                  RatingBar(
                    initialRating: rateing
                        .toDouble(),
                    itemSize: 20,
                    minRating: 1,
                    direction:
                    Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder:
                        (context, _) =>
                        Container(
                          height: 12,
                          child: SvgPicture.asset(
                            "assets/icons/ic_star.svg",
                            color: bloc
                                .getColor(),
                            width: 9,
                          ),
                        ),
                    onRatingUpdate: print,
                  ),

                  TextFormField(
                      initialValue:comment,
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_comment),
                        labelText: getTransrlate(context, 'AddComment'),
                      ),
                      onChanged: (String val) => comment = val,
                      validator: (value) {
                        if (value.isEmpty) {
                          return getTransrlate(context, 'avalidComment');
                        }
                        return null;
                      }
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: DialogButton(
                width: deviceWidth/4,
                color: bloc.getColor(),
                onPressed: () async {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    setState(() {
                      isloading=true;
                    });
                    form.save();
                    await ProductService.Createrating(name, email, id,rateing,comment.isEmpty?' ':comment);
                    Navigator.pop(context);
                    isloading=false;
                  }
                },
                child: Text(
                  getTransrlate(context, 'Comment'),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
        isloading?Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black45,
            child: Center(child:  CircularProgressIndicator(
                valueColor:  AlwaysStoppedAnimation<Color>(bloc.color)))):Container()
      ],
    );
  }
}