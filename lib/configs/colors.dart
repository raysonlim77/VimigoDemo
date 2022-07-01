import 'package:flutter/material.dart';

mixin AppColor {
  static final Color primaryColor = Color(0xFFffc037);

  static final Color forgroundColor = Color(0xFFffc037);

  static final Color darkForegroundColor = Color(0xff3d3f50);
  static final Color darkBackgroundColor = Color(0xff272936);
  static final Color lightForegroundColor = Color(0xffffffff);

  static final Color lightBackgroundColor = Color(0xfff2f2f2);
  static final List<BoxShadow> lightBoxShadow = [
    BoxShadow(
        color: Colors.grey.shade300,
        spreadRadius: 0.0,
        blurRadius: 5,
        offset: Offset(2.0, 2.0)),
    BoxShadow(
        color: Colors.grey.shade400,
        spreadRadius: 0.0,
        blurRadius: 5 / 2.0,
        offset: Offset(2.0, 2.0)),
    const BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 5,
        offset: Offset(-2.0, -2.0)),
    const BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 5 / 2,
        offset: Offset(-2.0, -2.0)),
  ];
  static final List<BoxShadow> darkBoxShadow = [
    BoxShadow(
        color: Colors.grey.shade300,
        spreadRadius: 0.0,
        blurRadius: 2,
        offset: Offset(2.0, 2.0)),
    BoxShadow(
        color: Colors.grey.shade400,
        spreadRadius: 0.0,
        blurRadius: 2 / 2.0,
        offset: Offset(2.0, 2.0)),
    const BoxShadow(
        color: Color(0xff3d3f50),
        spreadRadius: 2.0,
        blurRadius: 2,
        offset: Offset(-2.0, -2.0)),
    const BoxShadow(
        color: Color(0xff272936),
        spreadRadius: 2.0,
        blurRadius: 2 / 2,
        offset: Offset(-2.0, -2.0)),
  ];
  static const List<Color> orangeGradientScheme = [
    Color.fromRGBO(255, 148, 54, 1.0),
    Color.fromRGBO(255, 170, 0, 1.0),
    Color.fromRGBO(255, 189, 58, 1.0),
  ];
  static const List<Color> whiteGradientScheme = [
    Color(0xffE5E6E4),
    Color(0xffECECEB),
    Color(0xffF2F3F2),
  ];
  static LinearGradient get orangeGradient => LinearGradient(colors: [
        Color.fromRGBO(255, 148, 54, 1.0),
        Color.fromRGBO(255, 170, 0, 1.0),
        Color.fromRGBO(255, 189, 58, 1.0),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static LinearGradient get whiteGradient => LinearGradient(colors: [
        Color(0xffE5E6E4),
        Color(0xffECECEB),
        Color(0xffF2F3F2),
        Color(0xffF9F9F8),
        Color(0xffFFFFFF),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

const Color primary = Color(0xFFffc037);
const Color secondary = Color(0xFFFF2278);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);

const Color red = Color(0xFFec5766);
const Color green = Color(0xFF43aa8b);
const Color blue = Color(0xFF28c2ff);

const Color purple = Color(0xff5c4db1);
const Color pink = Color(0xffdc4f89);
const Color lightBlue = Color(0xffdbf0f1);
const Color darkBlue = Color(0xff39888e);
const Color yellow = Color(0xffffe9a7);
const Color grey = Color.fromRGBO(211, 211, 211, 1.0);

const Color lightWhite = Color(0xffffffff);
const Color darkWhite = Color(0xfff2f2f2);
const Color darkGrey = Color(0xff3d3f50);
const Color lightGrey = Color(0xffD3D3D3);
const Color primary2 = Color(0xFFfed42a);

const Color darkSecondary = Color(0xff861617);
const Color lightSecondary = Color(0xffc3414b);
const Color lightSecondary2 = Color(0xffe1a0a5);
const Color forgroundColor = Color(0xff3d3f50);
const Color backgroundColor = Color(0xff272936);
const double borderRadius = 27;
const double defaultPadding = 8;

const GREYSCALE_MATRIX = [
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];
