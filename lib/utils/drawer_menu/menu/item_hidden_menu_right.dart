import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';

class ItemHiddenMenuRight extends StatelessWidget {
  /// name of the menu item
  final String name;

  /// callback to recibe action click in item
  final Function onTap;

  final Color colorLineSelected;

  /// Base style of the text-item.
  final TextStyle baseStyle;

  /// style to apply to text when item is selected
  final TextStyle selectedStyle;

  final bool selected;

  ItemHiddenMenuRight({
    Key key,
    this.name,
    this.selected = false,
    this.onTap,
    this.colorLineSelected = Colors.blue,
    this.baseStyle,
    this.selectedStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(width: 32, child: Icon(
                        Feather.home,
                        size: 19,
                        color: Colors.white,
                      ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        getTransrlate(context, 'HomePage'),
                        style: (this.baseStyle ??
                            GoogleFonts.poppins(color: Colors.grey, fontSize: 14.0))
                            .merge(this.selected
                            ? this.selectedStyle ??
                            GoogleFonts.poppins(
                                color: Colors.white, fontSize: 14)
                            : GoogleFonts.poppins(
                            color: Colors.white, fontSize: 14)),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  )),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0)),
              child: Container(
                height: 40.0,
                color: selected ? colorLineSelected : Colors.transparent,
                width: 5.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
