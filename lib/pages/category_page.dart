import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/ExeansionTile.dart';
import 'package:shoppingapp/modal/category.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/service/categoryservice.dart';
import 'package:shoppingapp/service/productdervice.dart';
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
   List<ProductModel>products;

   List<Widget> contents;
@override
  void initState() {
 CategoryService().getMainCategory().then((value) {
   setState(() {
     maincat=value;
   });
 });
 ProductService.getNewProducts().then((value) {
   setState(() {
     products=value;
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
        contents:  showCategories(),
    )
      :Center(child:
      CircularProgressIndicator(
          valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))):
      Center(child:
      CircularProgressIndicator(
          valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))),
    );
  }

   List showCategories(){
     List<Widget> widgets = [];
     if (maincat!= null) {
       var list =  maincat;
       for (var i in list) {
         widgets.add(getChildren(subcats, i));
       }
     }else  CircularProgressIndicator(
         valueColor:  AlwaysStoppedAnimation<Color>(Provider.of<ThemeNotifier>(context).getColor()));
     return widgets;
   }
   Widget getChildren(List<Category> categories, Category category) {
     var children = categories.where((o) => o.parent == category.id).toList();
     return ListView.builder(
       itemCount: children.length,
       itemBuilder: (context, index) {
         return ExpansionTile(
           title: Text(
             children[index].name,
             style: GoogleFonts.poppins(color: Color(0xFF5D6A78)),
             textDirection: TextDirection.rtl,
           ),
           leading: null,
           children: [
             getProducet(products,children[index])
           ],
         );
       },
     );
   }
   Widget getProducet(List<ProductModel> products, Category category) {
     var childr = products.where((o) => o.categories[0].id == category.id).toList();

     return GridView.builder(
       primary: false,
       shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       gridDelegate:
       SliverGridDelegateWithFixedCrossAxisCount(
         childAspectRatio: 1.045,
         crossAxisCount: 3,
         mainAxisSpacing: 16,
       ),
       itemCount: childr == null ? 0 : childr.length,
       itemBuilder: (BuildContext context, int index) {
         return Padding(
           padding: const EdgeInsets.all(4.0),
           child:Center(
             child: Container(
               child: Column(
                 children: <Widget>[
                   ClipRRect(
                     child: CachedNetworkImage(
                       imageUrl: childr[index].images==null?
                       '':childr[index].images[0].src,
                       height: 75,
                       width: 84,
                       fit: BoxFit.cover,
                     ),
                     borderRadius: BorderRadius.circular(8),
                   ),
                   Padding(
                     padding:
                     const EdgeInsets.only(top: 2.0, bottom: 1.0),
                     child: Container(
                       width: 45,
                       child: AutoSizeText(
                         childr[index].name,
                         maxLines: 2,
                         minFontSize: 7,
                         style: GoogleFonts.poppins(
                           fontSize: 12,
                           color: Color(0xFF5D6A78),
                           fontWeight: FontWeight.w400,
                         ),
                       ),
                     ),
                   )
                 ],
               ),
             ),
           ),
         );
       },
     );
   }

}
