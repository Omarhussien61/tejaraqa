import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/filter_page.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/utils/commons/AddToCart.dart';
import 'package:shoppingapp/utils/dialogVeriation.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/widgets/commons/search_card.dart';

class SearchPage extends StatefulWidget {
  String searchEditor ;
  SearchPage({this.searchEditor});

  @override
  _SearchPageState createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  String deneme = "Dursun";
  bool _isLoading = false;
  final debouncer = Debouncer(milliseconds: 1000);
  List<ProductModel> filteredProduct = List();
  List<ProductModel> productModel;
  GlobalKey<AutoCompleteTextFieldState<ProductModel>> key = new GlobalKey();
  AutoCompleteTextField searchTextField;

  String oldest='order=asc&filter[meta_key]=total_sales&status=publish&';
  String New='order=desc&filter[meta_key]=total_sales&status=publish&';
  String LowToHigh='order=asc&orderby=price&filter[meta_key]=total_sales&status=publish&';
  String HighToLow='order=desc&orderby=price&filter[meta_key]=total_sales&status=publish&';

  @override
  void initState() {
    ubdateCategory(New);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 252, 252, 252),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        body: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: themeColor.getColor(),
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: ScreenUtil.getWidth(context) - 80,
                  margin: EdgeInsets.only(left: 22, top: 14),
                  padding: EdgeInsets.only(left: 18, right: 18),
                  height: 44,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 8.0,
                          spreadRadius: 1,
                          offset: Offset(0.0, 3)
                      )
                    ],
                    color: Theme.of(context).bottomAppBarColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icons/ic_search.svg",
                        color: Colors.black45,
                        height: 12,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 4),
                          height: 72,
                          child:searchTextField= AutoCompleteTextField<ProductModel>(
                            key: key,
                            clearOnSubmit: false,
                            suggestions: filteredProduct,
                            style: TextStyle(color: Colors.black, fontSize: 16.0),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: getTransrlate(context, 'search'),
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Color(0xFF5D6A78),
                                fontWeight: FontWeight.w400,
                              )),
                            itemFilter: (item, query) {
                              return item.name
                                  .toLowerCase()
                                  .startsWith(query.toLowerCase());
                            },
                            itemSorter: (a, b) {
                              return a.name.compareTo(b.name);
                            },
                            itemSubmitted: (item) {
                              setState(() {
                                searchTextField.textField.controller.text = item.name;
                              });
                            },
                            textChanged: (string) {
                              debouncer.run(() {
                                setState(() {
                                  filteredProduct = productModel.where((u) =>
                                  (u.name.toLowerCase().contains(string.toLowerCase())) ||
                                      (u.categories[0].name.toLowerCase().contains(string.toLowerCase()))||
                                      (u.sortDescription.toLowerCase().contains(string.toLowerCase()))
                                      ||
                                      (u.description.toLowerCase().contains(string.toLowerCase()))
                                  ).toList();
                                });
                              });
                            },
                            itemBuilder: (context, item) {
                              // ui for the autocompelete row
                              return row(item);
                            },
                          ),

                        ),


                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil.getWidth(context) /2,
                      margin: EdgeInsets.only(top: 24, left: 8),
                      padding: EdgeInsets.only(left: 18, right: 22),
                      height: 44,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 8.0,
                              spreadRadius: 1,
                              offset: Offset(0.0, 3))
                        ],
                        color: Theme.of(context).bottomAppBarColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                _sortingBottomSheet();
                              },
                              child: Container(
                                margin: EdgeInsets.all(12),
                                child: Row(children: <Widget>[
                                  RotatedBox(
                                      quarterTurns: 3,
                                      child: Icon(
                                        Ionicons.ios_swap,
                                        size: 16,
                                      )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    getTransrlate(context, 'Sort'),
                                    style: GoogleFonts.poppins(
                                        fontSize: 13, color: Color(0xFF5D6A78)),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(height: 600,
                        child: productModel==null?Center(child:
                        CircularProgressIndicator(
                            valueColor:  AlwaysStoppedAnimation<Color>(Provider.of<ThemeNotifier>(context).getColor()))):list(themeColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _sortingBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                Container(
                    margin: EdgeInsets.only(left: 36, top: 12),
                    child: Text(
                      "Sort Products By",
                      style: GoogleFonts.poppins(color: Color(0xFF5D6A78)),
                    )),
                InkWell(
                  onTap: () {
                    ubdateCategory(LowToHigh);
                    Navigator.pop(context);

                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 24),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox1.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(getTransrlate(context, 'SortByold'),
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    ubdateCategory(New);
                    Navigator.pop(context);

                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox2.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(getTransrlate(context, 'SortByNew'),
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    ubdateCategory(LowToHigh);
                    Navigator.pop(context);

                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox1.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(getTransrlate(context, 'SortByPriceLess'),
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    ubdateCategory(HighToLow);
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox1.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(getTransrlate(context, 'SortByPricemore'),
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        });
  }
  Widget list(ThemeNotifier themeColor) {
    return GridView.builder(
      primary: false,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisCount: 2,
      ),
      itemCount: filteredProduct == null ? 0 : filteredProduct.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child:SearchCard( themeColor: themeColor,product: filteredProduct[index],),
        );
      },
    );
  }
  void ubdateCategory(String url) {
    ProductService.getAllProducts(url).then((usersFromServer) {
      setState(() {
        productModel = usersFromServer;
        _isLoading=false;
        widget.searchEditor==null?filteredProduct = productModel:filteredProduct = productModel.where((u) =>
            (u.name.toLowerCase().contains(widget.searchEditor.toLowerCase())) ||
                (u.categories[0].name.toLowerCase().contains(widget.searchEditor.toLowerCase()))||
                (u.sortDescription.toLowerCase().contains(widget.searchEditor.toLowerCase()))
                ||
                (u.description.toLowerCase().contains(widget.searchEditor.toLowerCase()))
            ).toList();
      });

    });
  }
  Widget row(ProductModel productModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          productModel.name,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          productModel.price,
        ),
      ],
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
