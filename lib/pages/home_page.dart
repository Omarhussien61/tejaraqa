import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/category_list_view.dart';
import 'package:shoppingapp/widgets/homepage/discount_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';
import 'package:shoppingapp/widgets/homepage/slider_dot.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _carouselCurrentPage = 0;

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String value) {
      changeLocale(context, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      body: ListView(
        children: <Widget>[
          SearchBox(),
//              FlatButton(
//                onPressed: () {
//                  _onActionSheetPress(context);
//                },
//                child: Text(translate('button.change_language')),
//              ),
          CategoryListView(),
          InkWell(
            onTap: () {
              Nav.route(context, ProductDetailPage());
            },
            child: CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: false,
                  height: 175,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _carouselCurrentPage = index;
                    });
                  }),
            ),
          ),
          SliderDot(current: _carouselCurrentPage),
          DiscountList(
            themeColor: themeColor,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Daily opportunity",
              isCountShow: true,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ProductList(
            themeColor: themeColor,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Products You May Like",
              isCountShow: false,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Nav.route(context, ProductDetailPage());
            },
            child: CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: false,
                  height: 175,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _carouselCurrentPage = index;
                    });
                  }),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ProductList(
            themeColor: themeColor,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Most Top Rated",
              isCountShow: false,
            ),
          ),
          DiscountList(
            themeColor: themeColor,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Low-Priced Products",
              isCountShow: false,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ProductList(
            themeColor: themeColor,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Most recently looked",
              isCountShow: false,
            ),
          ),
          SizedBox(
            height: 36,
          ),
        ],
      ),
    );
  }
}
