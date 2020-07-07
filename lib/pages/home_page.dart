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
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _carouselCurrentPage = 0;
   List<Category> maincat;
  SQL_Helper helper = new SQL_Helper();
  SQL_Rercent sql_rercent = new SQL_Rercent();
  String contVeiw;

  Future<List<ProductModel>>productDiscount,productNew,moreSale,productview,product_low_priced;
  @override
  void initState() {
    updateListView();
    countCart();
    CategoryService().getMainCategory().then((value) {
      setState(() {
        maincat=value;
      });
    });
    productDiscount=ProductService.getAllProductsSale();
    product_low_priced=ProductService.getLow_Priced_Products();
    productNew=ProductService.getNewProducts();
    moreSale=ProductService.getMoreSaleProducts();
    super.initState();

  }
  updateListView(){
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Recentview>> ProductView = sql_rercent.getRecentViewList();
      ProductView.then((theList) {
        setState(() {
          contVeiw=theList[0].id.toString();
          for (int i = 1; i <= theList.length-1 ; i++){
            //items.add(this.recents[i].id.toString());
            contVeiw=contVeiw+','+theList[i].id.toString();
          }
          productview=ProductService.getRecentviewProducts(contVeiw);
        });
      });
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
          CategoryListView(maincat),
          CarouselSlider(
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
          SliderDot(current: _carouselCurrentPage),
          DiscountList(
            product: productDiscount,
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
            product: productNew,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Products You May Like",
              isCountShow: false,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          CarouselSlider(
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
          SizedBox(
            height: 8,
          ),
          ProductList(
            themeColor: themeColor,
            product: moreSale,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Most Top Rated",
              isCountShow: false,
            ),
          ),
          DiscountList(
            themeColor: themeColor,
            product: product_low_priced,
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
            product: productview,
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
  void countCart() async {
    helper.getCount().then((value) {
      Provider.of<ThemeNotifier>(context).intcountCart(value);
    });

  }

}
