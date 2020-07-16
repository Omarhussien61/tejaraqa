import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class SliderDotProductDetail extends StatelessWidget {
  const SliderDotProductDetail({
    Key key,
    @required int current,
     this.list,

  })  : _current = current,
        super(key: key);

  final int _current;
  final List<Images> list ;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map((url) {
        int index = list.indexOf(url);
        return Container(
          width: 12.0,
          height: 3.0,
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            shape: BoxShape.rectangle,
            color:
                _current == index ? themeColor.getColor() : Color(0xFFEEEEF3),
          ),
        );
      }).toList(),
    );
  }
}
