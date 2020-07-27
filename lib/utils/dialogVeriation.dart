import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoppingapp/modal/Product_variations.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';

import 'commons/AddToCart.dart';

class DialogVreations extends StatefulWidget {
  DialogVreations({
    Key key,
    @required this.product,
  }) : super(key: key);
  final ProductModel product;


  @override
  _DialogVreationsState createState() => new _DialogVreationsState(product);
}
class _DialogVreationsState extends State<DialogVreations> {

  List<Product_variations> product_variations;
  final formKey = GlobalKey<FormState>();
  bool isloading=false;
  double deviceHeight,deviceWidth;
  int checkboxValueA, checkboxValueB;
   ProductModel productselect;
String option;
  String price= '0';
  String photo= '0';

  _DialogVreationsState(this.productselect);

  @override
  void initState() {
    setState(() {
      price=widget.product.price;
      photo=widget.product.images[0].src;

    });
    ProductService.getVriationProducts(widget.product.id).then((usersFromServer) {
      setState(() {
        product_variations = usersFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc=Provider.of<ThemeNotifier>(context);
    deviceHeight=ScreenUtil.getHeight(context);
    deviceWidth=ScreenUtil.getWidth(context);
    return  AlertDialog(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
      title: CachedNetworkImage(imageUrl:photo ,),
      content:Form(
        key: formKey,
        child: SingleChildScrollView(
          child:product_variations!=null? Container(

            height: ScreenUtil.getHeight(context)/15,
            width: ScreenUtil.getWidth(context),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:  product_variations == null ? 0 : product_variations.length,
                itemBuilder: (BuildContext context, int position) {
                  return Container(
                    height: ScreenUtil.getHeight(context)/20,
                    width: ScreenUtil.getWidth(context)/4,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:product_variations[position].attributes == null ? 0 : product_variations[position].attributes.length,
                        itemBuilder: (BuildContext context, int pos) {
                          bool isSelected = checkboxValueA == position;
                          return  GestureDetector(
                            onTap: (){
                              setState(() {
                                checkboxValueA = position;
                                checkboxValueB=product_variations[position].id;
                                option=product_variations[position].attributes[pos].option;
                                price=product_variations[position].price;
                                photo=product_variations[position].image.src;

                              });
                            },
                            child: Card(
                              shape: isSelected
                                  ? new RoundedRectangleBorder(
                                  side: new BorderSide(color: bloc.getColor(), width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0))
                                  : new RoundedRectangleBorder(
                                  side: new BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Center(
                                  child: Text(
                                    product_variations[position].attributes[pos].option,
                                    style:TextStyle(
                                      fontFamily: 'El_Messiri',
                                      color: Colors.black,
                                      fontSize: ScreenUtil.getHeight(context)/35,
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          );
                        }),
                  );
                }),
          ):Container(
              height: ScreenUtil.getHeight(context)/20,
              width: ScreenUtil.getWidth(context)/4,
              child: Center(child:  CircularProgressIndicator(
                  valueColor:  AlwaysStoppedAnimation<Color>(bloc.getColor())))),
        ),
      ),
      actions: <Widget>[
        Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(getTransrlate(context, 'price')+' =  $price'+' \$ ',
            style: GoogleFonts.poppins(color:bloc.getColor() , fontSize: 20),
          ),
        )),
        SizedBox(
          width: ScreenUtil.getWidth(context)/3,
        ),
        checkboxValueA!=null? Center(
          child: DialogButton(
            width: deviceWidth/4,
            color: bloc.getColor(),
            onPressed: () async {
              final form = formKey.currentState;
              if (form.validate()) {
                form.save();
                save(productselect,product_variations[checkboxValueA].id,widget.product.name+' - '+option,product_variations[checkboxValueA].price,context);
                countCart(context);
                Navigator.pop(context);
              }
            },
            child: Text(
              getTransrlate(context, 'Confirm'),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ):Container()
      ],
    );
  }
}