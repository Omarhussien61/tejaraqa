import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> discountImageList = [
  'assets/images/prodcut1.png',
  'assets/images/prodcut2.png',
  'assets/images/prodcut3.png',
  'assets/images/prodcut4.png',
  'assets/images/prodcut5.png',
  'assets/images/prodcut1.png',
  'assets/images/prodcut7.png',
  'assets/images/prodcut8.png',
  'assets/images/prodcut9.png',
];

List<Widget> imageSliders = discountImageList
    .map((item) => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 1)),
            ],
          ),
          margin: EdgeInsets.only(left: 12.0, right: 16, top: 16, bottom: 16),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          color: Colors.red,
                          width: 230,
                          child: Image.asset(item,
                              fit: BoxFit.cover, width: 220.0))),
                  Align(
                    alignment: Alignment.centerLeft,
//                    child:Point(
//                      triangleHeight: 70.0,
//                      edge: Edge.RIGHT,
//                      child: Container(
//                        color: Colors.white,
//                        width: 225.0,
//                        height: 175.0,
//                        padding: EdgeInsets.only(left: 16, top: 54, right: 72),
//                        child: Text(
//                          "Kadın kıyafetlerinde bu aya degil bu yıla özel fırsatlar",
//                          overflow: TextOverflow.ellipsis,
//                          maxLines: 5,
//                          style: GoogleFonts.poppins(
//                            fontSize: 13,
//                            color: Color(0xFF5D6A78),
//                            fontWeight: FontWeight.w300,
//                          ),
//                        ),
//                      ),
//                    ),
                    child: Diagonal(
                      clipHeight: 70.0,
                      axis: Axis.vertical,
                      position: DiagonalPosition.BOTTOM_RIGHT,
                      child: Container(
                        color: Colors.white,
                        width: 200.0,
                        height: 175.0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 54, left: 12),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Color(0xFF5D6A78),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ))
    .toList();
