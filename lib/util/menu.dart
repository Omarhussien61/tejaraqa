///*
//*  product_reviews_widget.dart
//*  Xd-resources-ecommerce-ui
//*
//*  Created by .
//*  Copyright © 2018 . All rights reserved.
//    */
//
//import 'package:flutter/material.dart';
//
//
//class ProductReviewsWidget extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      body: Container(
//        constraints: BoxConstraints.expand(),
//        decoration: BoxDecoration(
//          color: Color.fromARGB(255, 245, 246, 248),
//        ),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: [
//            Container(
//              height: 341,
//              child: Stack(
//                alignment: Alignment.center,
//                children: [
//                  Positioned(
//                    left: 0,
//                    top: 0,
//                    right: 0,
//                    child: Container(
//                      height: 341,
//                      decoration: BoxDecoration(
//                        gradient: Gradients.primaryGradient,
//                      ),
//                      child: Container(),
//                    ),
//                  ),
//                  Positioned(
//                    left: 20,
//                    top: 33,
//                    right: 19,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.stretch,
//                      children: [
//                        Container(
//                          height: 44,
//                          child: Stack(
//                            alignment: Alignment.center,
//                            children: [
//                              Positioned(
//                                left: 0,
//                                top: 0,
//                                right: 0,
//                                child: Row(
//                                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                                  children: [
//                                    Align(
//                                      alignment: Alignment.topLeft,
//                                      child: Container(
//                                        width: 10,
//                                        height: 18,
//                                        margin: EdgeInsets.only(top: 3),
//                                        child: Image.asset(
//                                          "assets/images/back-4.png",
//                                          fit: BoxFit.none,
//                                        ),
//                                      ),
//                                    ),
//                                    Spacer(),
//                                    Align(
//                                      alignment: Alignment.topLeft,
//                                      child: Container(
//                                        width: 28,
//                                        height: 24,
//                                        child: Stack(
//                                          alignment: Alignment.center,
//                                          children: [
//                                            Positioned(
//                                              left: 7,
//                                              right: 0,
//                                              child: Image.asset(
//                                                "assets/images/cart-7.png",
//                                                fit: BoxFit.none,
//                                              ),
//                                            ),
//                                            Positioned(
//                                              left: 0,
//                                              top: 9,
//                                              right: 11,
//                                              child: Container(
//                                                height: 15,
//                                                decoration: BoxDecoration(
//                                                  color: AppColors.secondaryElement,
//                                                  boxShadow: [
//                                                    Shadows.secondaryShadow,
//                                                  ],
//                                                  borderRadius: BorderRadius.all(Radius.circular(7)),
//                                                ),
//                                                child: Column(
//                                                  mainAxisAlignment: MainAxisAlignment.center,
//                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                                                  children: [
//                                                    Container(
//                                                      margin: EdgeInsets.only(left: 6, right: 5),
//                                                      child: Text(
//                                                        "7",
//                                                        textAlign: TextAlign.left,
//                                                        style: TextStyle(
//                                                          color: AppColors.accentText,
//                                                          fontWeight: FontWeight.w400,
//                                                          fontSize: 10,
//                                                        ),
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Positioned(
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                                  children: [
//                                    Text(
//                                      "Faux Sued Ankle Boots",
//                                      textAlign: TextAlign.center,
//                                      style: TextStyle(
//                                        color: AppColors.primaryText,
//                                        fontWeight: FontWeight.w400,
//                                        fontSize: 15,
//                                      ),
//                                    ),
//                                    Expanded(
//                                      flex: 1,
//                                      child: Container(
//                                        margin: EdgeInsets.only(left: 28, top: 4, right: 32),
//                                        child: Row(
//                                          crossAxisAlignment: CrossAxisAlignment.stretch,
//                                          children: [
//                                            Align(
//                                              alignment: Alignment.topLeft,
//                                              child: Text(
//                                                "\$49.99",
//                                                textAlign: TextAlign.center,
//                                                style: TextStyle(
//                                                  color: AppColors.primaryText,
//                                                  fontWeight: FontWeight.w400,
//                                                  fontSize: 15,
//                                                ),
//                                              ),
//                                            ),
//                                            Spacer(),
//                                            Align(
//                                              alignment: Alignment.bottomLeft,
//                                              child: Container(
//                                                width: 42,
//                                                height: 19,
//                                                decoration: BoxDecoration(
//                                                  color: AppColors.secondaryElement,
//                                                  borderRadius: BorderRadius.all(Radius.circular(9.5)),
//                                                ),
//                                                child: Row(
//                                                  children: [
//                                                    Container(
//                                                      width: 10,
//                                                      height: 10,
//                                                      margin: EdgeInsets.only(left: 5),
//                                                      child: Image.asset(
//                                                        "assets/images/path-12-2.png",
//                                                        fit: BoxFit.none,
//                                                      ),
//                                                    ),
//                                                    Expanded(
//                                                      flex: 1,
//                                                      child: Container(
//                                                        margin: EdgeInsets.only(left: 2, right: 6),
//                                                        child: Text(
//                                                          "4.9",
//                                                          textAlign: TextAlign.center,
//                                                          style: TextStyle(
//                                                            color: AppColors.accentText,
//                                                            fontWeight: FontWeight.w400,
//                                                            fontSize: 12,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Align(
//                          alignment: Alignment.topCenter,
//                          child: Container(
//                            width: 24,
//                            height: 5,
//                            margin: EdgeInsets.only(top: 15),
//                            child: Image.asset(
//                              "assets/images/paging-indicators.png",
//                              fit: BoxFit.none,
//                            ),
//                          ),
//                        ),
//                        Align(
//                          alignment: Alignment.topCenter,
//                          child: Container(
//                            width: 220,
//                            height: 202,
//                            margin: EdgeInsets.only(top: 25),
//                            child: Image.asset(
//                              "assets/images/boots.png",
//                              fit: BoxFit.cover,
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Align(
//              alignment: Alignment.topRight,
//              child: Container(
//                width: 230,
//                height: 31,
//                margin: EdgeInsets.only(top: 15, right: 65),
//                child: Row(
//                  children: [
//                    Text(
//                      "Product",
//                      textAlign: TextAlign.left,
//                      style: TextStyle(
//                        color: AppColors.secondaryText,
//                        fontWeight: FontWeight.w400,
//                        fontSize: 15,
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 30),
//                      child: Text(
//                        "Details",
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          color: AppColors.secondaryText,
//                          fontWeight: FontWeight.w400,
//                          fontSize: 15,
//                        ),
//                      ),
//                    ),
//                    Spacer(),
//                    Container(
//                      width: 78,
//                      height: 31,
//                      child: Stack(
//                        alignment: Alignment.center,
//                        children: [
//                          Positioned(
//                            right: 0,
//                            child: Container(
//                              width: 78,
//                              height: 31,
//                              decoration: BoxDecoration(
//                                color: AppColors.primaryElement,
//                                borderRadius: BorderRadius.all(Radius.circular(15.5)),
//                              ),
//                              child: Container(),
//                            ),
//                          ),
//                          Positioned(
//                            right: 11,
//                            child: Text(
//                              "Reviews",
//                              textAlign: TextAlign.right,
//                              style: TextStyle(
//                                color: Color.fromARGB(255, 255, 105, 105),
//                                fontWeight: FontWeight.w400,
//                                fontSize: 15,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Container(
//              height: 131,
//              margin: EdgeInsets.only(left: 20, top: 25, right: 19),
//              child: Stack(
//                alignment: Alignment.center,
//                children: [
//                  Positioned(
//                    left: 0,
//                    top: 0,
//                    right: 0,
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.stretch,
//                      children: [
//                        Align(
//                          alignment: Alignment.topLeft,
//                          child: Container(
//                            width: 60,
//                            height: 60,
//                            decoration: BoxDecoration(
//                              color: Color.fromARGB(255, 183, 230, 230),
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Color.fromARGB(101, 183, 230, 230),
//                                  offset: Offset(0, 6),
//                                  blurRadius: 12,
//                                ),
//                              ],
//                              borderRadius: BorderRadius.all(Radius.circular(30)),
//                            ),
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.stretch,
//                              children: [
//                                Container(
//                                  margin: EdgeInsets.only(left: 16, right: 15),
//                                  child: Text(
//                                    "JD",
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                      color: Color.fromARGB(255, 133, 203, 203),
//                                      fontWeight: FontWeight.w400,
//                                      fontSize: 22,
//                                      letterSpacing: 0.88,
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          flex: 1,
//                          child: Container(
//                            margin: EdgeInsets.only(left: 20, top: 1),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.stretch,
//                              children: [
//                                Container(
//                                  height: 33,
//                                  child: Row(
//                                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                                    children: [
//                                      Align(
//                                        alignment: Alignment.topLeft,
//                                        child: Container(
//                                          margin: EdgeInsets.only(top: 15),
//                                          child: Text(
//                                            "Jane Doe",
//                                            textAlign: TextAlign.left,
//                                            style: TextStyle(
//                                              color: AppColors.primaryText,
//                                              fontWeight: FontWeight.w400,
//                                              fontSize: 15,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                      Spacer(),
//                                      Align(
//                                        alignment: Alignment.topLeft,
//                                        child: Opacity(
//                                          opacity: 0.5,
//                                          child: Text(
//                                            "10 Oct, 2018",
//                                            textAlign: TextAlign.right,
//                                            style: TextStyle(
//                                              color: AppColors.primaryText,
//                                              fontWeight: FontWeight.w400,
//                                              fontSize: 14,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Expanded(
//                                  flex: 1,
//                                  child: Align(
//                                    alignment: Alignment.topRight,
//                                    child: Container(
//                                      width: 255,
//                                      margin: EdgeInsets.only(top: 5, right: 1),
//                                      child: Stack(
//                                        alignment: Alignment.center,
//                                        children: [
//                                          Positioned(
//                                            top: 0,
//                                            right: 61,
//                                            child: Text(
//                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
//                                              textAlign: TextAlign.left,
//                                              style: TextStyle(
//                                                color: AppColors.primaryText,
//                                                fontWeight: FontWeight.w400,
//                                                fontSize: 14,
//                                              ),
//                                            ),
//                                          ),
//                                          Positioned(
//                                            right: 0,
//                                            bottom: 0,
//                                            child: Image.asset(
//                                              "assets/images/image-7.png",
//                                              fit: BoxFit.cover,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  Positioned(
//                    left: 79,
//                    top: 0,
//                    child: Image.asset(
//                      "assets/images/rating.png",
//                      fit: BoxFit.none,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Spacer(),
//            Container(
//              height: 131,
//              child: Stack(
//                alignment: Alignment.center,
//                children: [
//                  Positioned(
//                    left: 20,
//                    right: 19,
//                    bottom: 0,
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.stretch,
//                      children: [
//                        Align(
//                          alignment: Alignment.topLeft,
//                          child: Container(
//                            width: 60,
//                            height: 60,
//                            decoration: BoxDecoration(
//                              color: Color.fromARGB(255, 196, 230, 183),
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Color.fromARGB(101, 183, 230, 230),
//                                  offset: Offset(0, 6),
//                                  blurRadius: 12,
//                                ),
//                              ],
//                              borderRadius: BorderRadius.all(Radius.circular(30)),
//                            ),
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.stretch,
//                              children: [
//                                Container(
//                                  margin: EdgeInsets.only(left: 16, right: 15),
//                                  child: Text(
//                                    "SS",
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                      color: Color.fromARGB(255, 133, 203, 203),
//                                      fontWeight: FontWeight.w400,
//                                      fontSize: 22,
//                                      letterSpacing: 0.88,
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          flex: 1,
//                          child: Container(
//                            margin: EdgeInsets.only(left: 20, top: 39),
//                            child: Stack(
//                              alignment: Alignment.center,
//                              children: [
//                                Positioned(
//                                  top: 0,
//                                  right: 8,
//                                  child: Text(
//                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
//                                    textAlign: TextAlign.left,
//                                    style: TextStyle(
//                                      color: AppColors.primaryText,
//                                      fontWeight: FontWeight.w400,
//                                      fontSize: 14,
//                                    ),
//                                  ),
//                                ),
//                                Positioned(
//                                  left: 0,
//                                  right: 0,
//                                  bottom: 0,
//                                  child: Row(
//                                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                                    children: [
//                                      Align(
//                                        alignment: Alignment.bottomLeft,
//                                        child: Container(
//                                          width: 44,
//                                          height: 44,
//                                          decoration: BoxDecoration(
//                                            color: AppColors.primaryElement,
//                                          ),
//                                          child: Container(),
//                                        ),
//                                      ),
//                                      Align(
//                                        alignment: Alignment.bottomLeft,
//                                        child: Container(
//                                          width: 44,
//                                          height: 44,
//                                          margin: EdgeInsets.only(left: 9),
//                                          decoration: BoxDecoration(
//                                            color: AppColors.primaryElement,
//                                          ),
//                                          child: Container(),
//                                        ),
//                                      ),
//                                      Spacer(),
//                                      Align(
//                                        alignment: Alignment.bottomLeft,
//                                        child: Container(
//                                          width: 44,
//                                          height: 44,
//                                          margin: EdgeInsets.only(right: 8),
//                                          decoration: BoxDecoration(
//                                            color: AppColors.primaryElement,
//                                          ),
//                                          child: Container(),
//                                        ),
//                                      ),
//                                      Align(
//                                        alignment: Alignment.bottomLeft,
//                                        child: Container(
//                                          width: 44,
//                                          height: 44,
//                                          decoration: BoxDecoration(
//                                            color: AppColors.primaryElement,
//                                          ),
//                                          child: Container(),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          flex: 1,
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.stretch,
//                            children: [
//                              Container(
//                                height: 18,
//                                child: Row(
//                                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                                  children: [
//                                    Align(
//                                      alignment: Alignment.topLeft,
//                                      child: Container(
//                                        width: 61,
//                                        height: 13,
//                                        child: Image.asset(
//                                          "assets/images/rating-7.png",
//                                          fit: BoxFit.none,
//                                        ),
//                                      ),
//                                    ),
//                                    Spacer(),
//                                    Align(
//                                      alignment: Alignment.topLeft,
//                                      child: Container(
//                                        margin: EdgeInsets.only(top: 1),
//                                        child: Opacity(
//                                          opacity: 0.5,
//                                          child: Text(
//                                            "7 Sep, 2018",
//                                            textAlign: TextAlign.right,
//                                            style: TextStyle(
//                                              color: AppColors.primaryText,
//                                              fontWeight: FontWeight.w400,
//                                              fontSize: 14,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Align(
//                                alignment: Alignment.topLeft,
//                                child: Text(
//                                  "Sam Smith",
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                    color: AppColors.primaryText,
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: 15,
//                                  ),
//                                ),
//                              ),
//                              Spacer(),
//                              Align(
//                                alignment: Alignment.topRight,
//                                child: Container(
//                                  width: 44,
//                                  height: 44,
//                                  margin: EdgeInsets.only(right: 1),
//                                  decoration: BoxDecoration(
//                                    color: AppColors.primaryElement,
//                                  ),
//                                  child: Container(),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  Positioned(
//                    left: 0,
//                    right: 0,
//                    bottom: 37,
//                    child: Container(
//                      height: 78,
//                      decoration: BoxDecoration(
//                        gradient: LinearGradient(
//                          begin: Alignment(0.5, 0),
//                          end: Alignment(0.5, 0.32085),
//                          stops: [
//                            0,
//                            1,
//                          ],
//                          colors: [
//                            Color.fromARGB(173, 245, 246, 248),
//                            Color.fromARGB(255, 245, 246, 248),
//                          ],
//                        ),
//                      ),
//                      child: Row(
//                        children: [
//                          Container(
//                            width: 165,
//                            height: 46,
//                            margin: EdgeInsets.only(left: 15),
//                            decoration: BoxDecoration(
//                              color: AppColors.primaryElement,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Color.fromARGB(39, 114, 124, 142),
//                                  offset: Offset(0, 5),
//                                  blurRadius: 10,
//                                ),
//                              ],
//                              borderRadius: BorderRadius.all(Radius.circular(23)),
//                            ),
//                            child: Row(
//                              children: [
//                                Container(
//                                  margin: EdgeInsets.only(left: 26),
//                                  child: Text(
//                                    "SHARE THIS",
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                      color: AppColors.secondaryText,
//                                      fontWeight: FontWeight.w400,
//                                      fontSize: 12,
//                                      letterSpacing: 0.72,
//                                    ),
//                                  ),
//                                ),
//                                Spacer(),
//                                Container(
//                                  width: 30,
//                                  height: 31,
//                                  margin: EdgeInsets.only(right: 7),
//                                  decoration: BoxDecoration(
//                                    color: AppColors.accentElement,
//                                    borderRadius: BorderRadius.all(Radius.circular(15)),
//                                  ),
//                                  child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                                    children: [
//                                      Container(
//                                        height: 13,
//                                        margin: EdgeInsets.symmetric(horizontal: 10),
//                                        child: Image.asset(
//                                          "assets/images/group-27.png",
//                                          fit: BoxFit.none,
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Spacer(),
//                          Container(
//                            width: 165,
//                            height: 46,
//                            margin: EdgeInsets.only(right: 15),
//                            decoration: BoxDecoration(
//                              color: AppColors.secondaryElement,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Color.fromARGB(101, 255, 105, 105),
//                                  offset: Offset(0, 5),
//                                  blurRadius: 10,
//                                ),
//                              ],
//                              borderRadius: BorderRadius.all(Radius.circular(23)),
//                            ),
//                            child: Row(
//                              children: [
//                                Container(
//                                  margin: EdgeInsets.only(left: 23),
//                                  child: Text(
//                                    "ADD TO CART",
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                      color: AppColors.accentText,
//                                      fontWeight: FontWeight.w400,
//                                      fontSize: 12,
//                                      letterSpacing: 0.72,
//                                    ),
//                                  ),
//                                ),
//                                Spacer(),
//                                Container(
//                                  width: 29,
//                                  height: 30,
//                                  margin: EdgeInsets.only(right: 8),
//                                  child: Image.asset(
//                                    "assets/images/icon.png",
//                                    fit: BoxFit.none,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}