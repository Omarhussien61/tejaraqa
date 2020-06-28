import 'package:flutter/material.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/dummy_data/discountImages.dart';

class SliderDot extends StatelessWidget {
  const SliderDot({
    Key key,
    @required int current,
  })  : _current = current,
        super(key: key);

  final int _current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: discountImageList.map((url) {
        int index = discountImageList.indexOf(url);
        return Container(
          width: 12.0,
          height: 2.0,
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            shape: BoxShape.rectangle,
            color: _current == index ? Color(0xFF0055FF) : textColor,
          ),
        );
      }).toList(),
    );
  }
}
