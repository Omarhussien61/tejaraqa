import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shoppingapp/pages/search_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesListView(
      title: "YOUR TITLES",
      categories: [
        'ic_lamp.svg',
        'ic_couch.svg',
        'ic_baby.svg',
        'ic_headphone.svg',
        'ic_phone.svg',
        'ic_glass.svg',
        'ic_couch.svg',
        'ic_lamp.svg'
      ],
      categoryTitle: [
        'All',
        'Dress',
        'Electronic',
        'Home',
        'Baby',
        'Fashion',
        'Jewel',
        'Book'
      ],
    );
  }
}

class CategoriesListView extends StatelessWidget {
  final String title;
  final List<String> categories;
  final List<String> categoryTitle;

  const CategoriesListView(
      {Key key,
      @required this.title,
      @required this.categories,
      @required this.categoryTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14, left: 4),
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
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
                    child: SvgPicture.asset(
                      "assets/icons/" + categories[index],
                      color: categoryIconColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  categoryTitle[index],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
