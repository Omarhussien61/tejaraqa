import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Recentview.dart';
import 'package:shoppingapp/modal/category.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/service/categoryservice.dart';
import 'package:shoppingapp/service/productdervice.dart';

import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
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
  Future<List<ProductModel>> productDiscount,
      productNew,
      moreSale,
      productview,
      product_low_priced;

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
  bool connected;

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
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          connected = connectivity != ConnectivityResult.none;
          return themeColor.config_model!=null?
          themeColor.config_model.offlineAppMode
              ? getListview(context)
              : connected
                  ? getListview(context)
                  : Center(
                      child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/not_found_smile.PNG',
                            height: ScreenUtil.getHeight(context) / 2,
                          ),
                          Text(getTransrlate(context, 'NotConnection')),
                          SizedBox(
                            height: 50,
                          ),
                          GFButton(
                            onPressed: () {
                              //Nav.route(context, SearchPage());
                            },
                            text: getTransrlate(context, 'retry'),
                            color: themeColor.getColor(),
                            textStyle: GoogleFonts.cairo(fontSize: 18),
                          )
                        ],
                      ),
                    )):Center(
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/not_found_smile.PNG',
                      height: ScreenUtil.getHeight(context) / 2,
                    ),
                    Text(getTransrlate(context, 'NotConnection')),
                    SizedBox(
                      height: 50,
                    ),
                    GFButton(
                      onPressed: () {
                        //Nav.route(context, SearchPage());
                      },
                      text: getTransrlate(context, 'retry'),
                      color: themeColor.getColor(),
                      textStyle: GoogleFonts.cairo(fontSize: 18),
                    )
                  ],
                ),
              ));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }

  void countCart() async {
    helper.getCount().then((value) {
      Provider.of<ThemeNotifier>(context).intcountCart(value);
    });
  }

  Widget getWidget(String name) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    switch (name) {
      case 'SearchBox':
        return  themeColor.config_model.searchtextbox != null
            ? themeColor.config_model.searchtextbox ? SearchBox() : Container()
            : Container();
        break;
      case 'productCategories':
        return  themeColor.config_model.productCategories != null
            ? themeColor.config_model.productCategories
            ? CategoryListView(widget.maincat)
            : Container()
            : Container();
        break;
      case 'Slider':
        return    themeColor.config_model.slider != null
            ? themeColor.config_model.slider
            ? Container()
            : Container()
            : Container();
      case 'productSale':
        return  themeColor.config_model.productSale != null
            ? themeColor.config_model.productSale
            ? DiscountList(
          product: widget.productDiscount,
          themeColor: themeColor,
          productListTitleBar: ProductListTitleBar(
            themeColor: themeColor,
            title: getTransrlate(context, 'Dailyopportunity'),
            isCountShow: false,
          ),
        )
            : Container()
            : Container();
        break;

      case 'newProduct':
        return  themeColor.config_model.newProduct != null
            ? themeColor.config_model.newProduct
            ? ProductList(
          themeColor: themeColor,
          product: widget.productNew,
          productListTitleBar: ProductListTitleBar(
            themeColor: themeColor,
            title: getTransrlate(context, 'ProductsLike'),
            isCountShow: false,
          ),
        )
            : Container()
            : Container();
        break;
        case 'topProduct':
      return themeColor.config_model.topProduct != null
          ? themeColor.config_model.topProduct
          ? ProductList(
        themeColor: themeColor,
        product: widget.moreSale,
        productListTitleBar: ProductListTitleBar(
          themeColor: themeColor,
          title: getTransrlate(context, 'MostRated'),
          isCountShow: false,
        ),
      )
          : Container()
          : Container();
      break; case 'lowPriced':
      return    themeColor.config_model.lowPriced != null
          ? themeColor.config_model.lowPriced
          ? DiscountList(
        themeColor: themeColor,
        product: widget.product_low_priced,
        productListTitleBar: ProductListTitleBar(
          themeColor: themeColor,
          title: getTransrlate(context, 'Low-PricedProducts'),
          isCountShow: false,
        ),
      )
          : Container()
          : Container();
      break;
      case 'mostRecentlyLooked':
      return themeColor.config_model.mostRecentlyLooked != null
          ? themeColor.config_model.mostRecentlyLooked
          ? widget.productview == null
          ? Container()
          : ProductList(
        themeColor: themeColor,
        product: widget.productview,
        productListTitleBar: ProductListTitleBar(
          themeColor: themeColor,
          title: getTransrlate(context, 'Mostrecently'),
          isCountShow: false,
        ),
      )
          : Container()
          : Container();
      break;
      default:
        return Container();
    }
  }

  Widget getListview(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

      return  ListView.builder(
            shrinkWrap: true,
            itemCount: themeColor.config_model.sortHome.length,
            itemBuilder: (BuildContext context, int index) {
              return getWidget(themeColor.config_model.sortHome[index]);
            });

  }

}
