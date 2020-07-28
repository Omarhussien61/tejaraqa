import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Favorite.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
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
  FavoriteProductsPage({Key key}) : super(key: key);

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body:themeColor.isLogin? SingleChildScrollView(
            child: Column(
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
        )):Container(
          child: Center(child: Text(getTransrlate(context, 'registration'))),
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
