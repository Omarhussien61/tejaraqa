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
      margin: EdgeInsets.only(bottom: 15.0,left: 24),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.only( right: 20),

                  child: Row(
                    children: <Widget>[
                      Container(width: 32, child: Icon(
                        Feather.home,
                        size: 22,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        getTransrlate(context, 'HomePage'),
                        style: (this.baseStyle ??
                            GoogleFonts.cairo(color: Colors.grey,
                                fontWeight: FontWeight.w700,fontSize: 16.0))
                            .merge(this.selected
                            ? this.selectedStyle ??
                            GoogleFonts.cairo(
                              fontWeight: FontWeight.w700,
                                color: Colors.white, fontSize: 17)
                            : GoogleFonts.cairo(
                            fontWeight: FontWeight.w700,
                            color: Colors.white, fontSize: 16)),
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
