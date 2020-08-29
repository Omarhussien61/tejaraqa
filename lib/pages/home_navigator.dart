import 'package:badges/badges.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/category_page.dart';
import 'package:shoppingapp/pages/favorite_products_page.dart';
import 'package:shoppingapp/pages/home_page.dart';
import 'package:shoppingapp/pages/my_profile_page.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/modal/category.dart';
import 'package:shoppingapp/service/categoryservice.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/utils/util/recentId.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shoppingapp/modal/Recentview.dart';
class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();


}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _currentPage = 0;

  List<Category> maincat;
  Future<List<ProductModel>>productDiscount,productNew,moreSale,productview,product_low_priced;
  SQL_Helper helper = new SQL_Helper();
  SQL_Rercent sql_rercent = new SQL_Rercent();
  String contVeiw;



  @override
  void initState() {
    getListData();


  }
  updateListView(){
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Recentview>> ProductView = sql_rercent.getRecentViewList();
      ProductView.then((theList) {
        theList!=null||theList.isNotEmpty?
        setState(() {
          contVeiw=theList[0].id.toString();
          for (int i = 1; i <= theList.length-1 ; i++){
            //items.add(this.recents[i].id.toString());
            contVeiw=contVeiw+','+theList[i].id.toString();
          }
          productview=ProductService.getRecentviewProducts(contVeiw);
        }):0;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    List<Widget> _pages = [
      HomePage(maincat,productDiscount,productNew,moreSale,productview,product_low_priced),
      CategoryPage(),
      ShoppingCartPage(),
      FavoriteProductsPage(),
      MyProfilePage()
    ];
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: ConvexAppBar(
          color: Color(0xFF5D6A78),
          backgroundColor: Colors.white,
          activeColor: themeColor.getColor(),
          elevation: 0.0,
          top: -28,
          onTap: (int val) {
            if (val == _currentPage) return;
            setState(() {
              _currentPage = val;
            });
          },
          curveSize: 0,
          initialActiveIndex: _currentPage,
          style: TabStyle.fixedCircle,
          items: <TabItem>[
            TabItem(icon: Feather.home, title: ''),
            TabItem(icon: Icons.apps, title: ''),
            TabItem(icon: bottomCenterItem(themeColor), title: ''),
            TabItem(icon: Feather.heart, title: ''),
            TabItem(icon: Feather.user, title: ''),
          ],
        ),
      ),
      body: RefreshIndicator(child:
      _pages[_currentPage],
      onRefresh: ()async{
        getListData();
        },),
    );
  }




  bottomCenterItem(ThemeNotifier themeColor) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 1)),
            ], color: Colors.white, borderRadius: BorderRadius.circular(32)),
            child: Align(
              child: Badge(
                badgeColor: themeColor.getColor(),
                padding: EdgeInsets.all(4),
                showBadge: themeColor.countCart!=0,
                badgeContent: Text(
                 themeColor.countCart.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: SvgPicture.asset(
                    "assets/icons/ic_shopping_cart_bottom.svg"),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }

   getListData() async {
    CategoryService().getMainCategory().then((value) {
      setState(() {
        maincat=value;
        productDiscount=ProductService.getAllProductsSale();
        product_low_priced=ProductService.getLow_Priced_Products();
        productNew=ProductService.getNewProducts();
        moreSale=ProductService.getMoreSaleProducts();
      });
      return true;
    });
    updateListView();

  }


}
