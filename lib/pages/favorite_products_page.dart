import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Favorite.dart';
import 'package:shoppingapp/pages/search_page.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_favorite.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';
import 'package:shoppingapp/widgets/wish_list/rounded_tab_bar.dart';
import 'package:shoppingapp/widgets/wish_list/wish_list_item.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProductsPage extends StatefulWidget {
   bool fav_state;
   FavoriteProductsPage(this.fav_state,{Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<FavoriteProductsPage>
    with SingleTickerProviderStateMixin {
  favorite_sql helper = new favorite_sql();
  List<FavoriteModel>favorites;
  @override
  void initState() {
    updateListView();
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    if (favorites == null||favorites.isEmpty) {
      //favorites = new List<Address_shiping>();
      setState(() {
        updateListView();
      });
    }
    return Scaffold(
      appBar: widget.fav_state? PreferredSize(
        preferredSize: Size.fromHeight(42.0), // here the desired height
        child: AppBar(
          backgroundColor: greyBackground,
          elevation: 0,
          centerTitle: true,
          title: Text(
            getTransrlate(context, 'MyFav'),
            style:
            GoogleFonts.cairo(color: Color(0xFF5D6A78), fontSize: 15),
          ),
          leading: InkWell(
            onTap:() {Navigator.pop(context);},
            child: Icon(
              Icons.chevron_left,
              color: textColor,
              size: 32,
            ),
          ),
        ),
      ):null,
      backgroundColor: whiteColor,
      body:themeColor.isLogin? SingleChildScrollView(
          child:favorites == null||favorites.isEmpty? Center(
            child: Hero(
              tag: 'icon',
              child: Column(
                children: [

                  Container(
                    height: 400,
                    child: CachedNetworkImage(
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageUrl:
                        'https://d2.woo2.app/wp-content/uploads/2020/08/3-removebg-preview.png'),
                  ),
                  Text(getTransrlate(context, 'nofavorites')),
                  SizedBox(
                    height: 50,
                  ),
                  GFButton(
                    onPressed: (){
                      Nav.route(context, SearchPage());
                    },
                    text: getTransrlate(context, 'Browse'),
                    color: themeColor.getColor(),
                    textStyle: GoogleFonts.cairo(
                        fontSize: 18
                    ),
                  )
                ],
              ),
            ),
          ):Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 26,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: favorites==null?0:favorites.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  WishListItem(favoriteModel: favorites[index]),
                  InkWell(
                    child: Icon(
                      Feather.trash,
                      color: themeColor.getColor(),
                      size: 25,
                    ),
                    onTap: (){
                      delete(context,favorites[index]);
                    },
                  )
                ],
              );
            },
          )
        ],
      )):
      Center(
        child: Container(
          height:400  ,
    child: Center(child: Column(
        children: [
          SizedBox(
            height: 100,
          ),

          Center(child: Text(getTransrlate(context, 'PleaseLogin'))),
          SizedBox(
            height: 100,
          ),

          GFButton(
            onPressed: (){
              Nav.route(context, LoginPage());
            },
            text: getTransrlate(context, 'login'),
            color: themeColor.getColor(),
            textStyle: GoogleFonts.cairo(
                fontSize: 18
            ),
          )
        ],
    )),
    ),
      ),
    );
  }
  void updateListView() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<FavoriteModel>> students = helper.getStudentList();
      students.then((theList) {
        setState(() {
          this.favorites = theList;
        });
      });
    });
  }
  void delete(BuildContext context, FavoriteModel student) async {
    favorite_sql helper = new favorite_sql();
    int ressult = await helper.deleteAddress(student.id);
    if (ressult != 0) {
      updateListView();

    }
  }


}
