import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/category.dart';
import 'package:shoppingapp/service/categoryservice.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/dummy_data/category.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/vertical_tab/vertical_tab.dart';
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}
class _CategoryPageState extends State<CategoryPage> {

   List<Category> maincat,subcats;
   List<Widget> contents;
@override
  void initState() {
 CategoryService().getMainCategory().then((value) {
   setState(() {
     maincat=value;
   });
 });
 CategoryService().getSubCategory().then((value) {
   setState(() {
     subcats=value;
   });

 });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: greyBackground,
      body:maincat!=null?subcats!=null? VerticalTabs(
        indicatorColor: themeColor.getColor(),
        selectedTabBackgroundColor: whiteColor,
        tabBackgroundColor: themeColor.getColor(),
        backgroundColor: greyBackground,
        direction: TextDirection.rtl,
        tabsWidth: 48,
        maincat: maincat,
        subcats: subcats,
        contents: contents,
      ):Center(child:
      CircularProgressIndicator(
          valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))):
      Center(child:
      CircularProgressIndicator(
          valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))),
    );
  }
  Widget tabsContent(ThemeNotifier themeColor, String caption,
      [String description = '']) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      color: greyBackground,
      child: ListView.builder(
        itemCount: subcats.length,
        itemBuilder: (context, index) {
          contents.add(expansionTile(themeColor, subcats[index].name));
          return expansionTile(themeColor, subcats[index].name);
        },
      ),
    );
  }
  Widget expansionTile(themeColor, String title) {
    return Theme(
      data: ThemeData(accentColor: themeColor.getColor()),
      child: ExpansionTile(
        title: Text(
          title,
          style: GoogleFonts.poppins(color: Color(0xFF5D6A78)),
          textDirection: TextDirection.ltr,
        ),
        leading: null,
//        trailing: Icon(
//          Icons.add,
//          size: 0,
//        ),
        children: [
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1.045,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(subCategoriesImages.length, (index) {
                  return Center(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.asset(
                              "assets/images/${subCategoriesImages[index]}.png",
                              height: 75,
                              width: 84,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 2.0, bottom: 1.0),
                            child: AutoSizeText(
                              subCategoriesTitle[index],
                              maxLines: 2,
                              minFontSize: 7,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Color(0xFF5D6A78),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          )
        ],
      ),
    );
  }
}
