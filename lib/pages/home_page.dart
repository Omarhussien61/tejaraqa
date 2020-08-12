import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Recentview.dart';
import 'package:shoppingapp/modal/category.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/service/categoryservice.dart';
import 'package:shoppingapp/service/productdervice.dart';

import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/recentId.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:shoppingapp/widgets/homepage/category_list_view.dart';
import 'package:shoppingapp/widgets/homepage/discount_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';
import 'package:shoppingapp/widgets/homepage/slider_dot.dart';
class HomePage extends StatefulWidget {

  List<Category> maincat;
  Future<List<ProductModel>>productDiscount,productNew,moreSale,productview,product_low_priced;
  HomePage(this.maincat, this.productDiscount, this.productNew, this.moreSale,
      this.productview, this.product_low_priced);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _carouselCurrentPage = 0;
  SQL_Helper helper = new SQL_Helper();
  SQL_Rercent sql_rercent = new SQL_Rercent();
  String contVeiw;
  @override
  void initState() {
    //updateListView();
    countCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      body: ListView(
        children: <Widget>[
          themeColor.config_model.searchtextbox? SearchBox():Container(),
          themeColor.config_model.productCategories? CategoryListView(widget.maincat):Container(),
          themeColor.config_model.slider? CarouselSlider(
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
          ):Container(),
          themeColor.config_model.slider? SliderDot(current: _carouselCurrentPage):Container(),
          themeColor.config_model.productSale? DiscountList(
            product: widget.productDiscount,
            themeColor: themeColor,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Daily opportunity",
              isCountShow: true,
            ),
          ):Container(),
          SizedBox(
            height: 8,
          ),
          themeColor.config_model.newProduct?ProductList(
            themeColor: themeColor,
            product: widget.productNew,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Products You May Like",
              isCountShow: false,
            ),
          ):Container(),
          SizedBox(
            height: 8,
          ),
          themeColor.config_model.slider? CarouselSlider(
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
          ):Container(),
          SizedBox(
            height: 8,
          ),
          themeColor.config_model.topProduct? ProductList(
            themeColor: themeColor,
            product: widget.moreSale,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Most Top Rated",
              isCountShow: false,
            ),
          ):Container(),
          themeColor.config_model.lowPriced? DiscountList(
            themeColor: themeColor,
            product: widget.product_low_priced,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Low-Priced Products",
              isCountShow: false,
            ),
          ):Container(),
          SizedBox(
            height: 8,
          ),
          themeColor.config_model.mostRecentlyLooked? widget.productDiscount==null?Container():ProductList(
            themeColor: themeColor,
            product: widget.productview,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Most recently looked",
              isCountShow: false,
            ),
          ):Container(),
          SizedBox(
            height: 36,
          ),
        ],
      ),
    );
  }
  void countCart() async {
    helper.getCount().then((value) {
      Provider.of<ThemeNotifier>(context).intcountCart(value);
    });
  }
}
