import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/category.dart';
import 'package:shoppingapp/pages/search_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class CategoryListView extends StatelessWidget {
  List<Category> maincat;

  CategoryListView(this.maincat);

  @override
  Widget build(BuildContext context) {
    return CategoriesListView(
      title: "YOUR TITLES",
      categories:maincat,
    );
  }
}

class CategoriesListView extends StatelessWidget {
  final String title;
  final List<Category> categories;

  const CategoriesListView(
      {Key key,
      @required this.title,
      @required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14, left: 4),
      height: 95,
      child: Center(
        child:categories==null?Center(child:
        CircularProgressIndicator(
            valueColor:  AlwaysStoppedAnimation<Color>(Provider.of<ThemeNotifier>(context).getColor()))):
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:categories==null?0:categories.length,
          itemBuilder: (BuildContext context, int index) {
            print(categories[0].image.src);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: SearchPage(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 55,
                    height: 63,
                    margin:
                        EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 5.0,
                            spreadRadius: 1,
                            offset: Offset(0.0, 1)),
                      ],
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child:  CachedNetworkImage(
                        imageUrl: (categories[index].image==null)?
                        'http://arabimagefoundation.com/images/defaultImage.png'
                            :categories[index].image.src,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      categories[index].name,
                      maxLines:1,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
