import 'package:flutter/material.dart';

import 'colors.dart';

mixin AppStyle {
  static final ThemeData dark = ThemeData.dark();
  static final ThemeData light = ThemeData.light();
  static ThemeData get lightTheme => ThemeData.light().copyWith(
        textTheme: _lightTextTheme(light.textTheme),
        brightness: Brightness.light,
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColor.primaryColor,
            selectionColor: AppColor.lightBackgroundColor,
            selectionHandleColor: AppColor.primaryColor),
        primaryColor: AppColor.primaryColor,
        primaryColorDark: AppColor.primaryColor,
        primaryColorLight: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.lightBackgroundColor,
        cardColor: AppColor.lightForegroundColor,
        secondaryHeaderColor: AppColor.primaryColor,
        iconTheme: IconThemeData(color: AppColor.primaryColor),
        canvasColor: AppColor.lightForegroundColor,
        focusColor: AppColor.primaryColor,
        indicatorColor: AppColor.primaryColor,
        backgroundColor: AppColor.lightBackgroundColor,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: AppColor.primaryColor)
            .copyWith(secondary: AppColor.primaryColor),
      );

  static TextTheme _lightTextTheme(TextTheme light) {
    return light.copyWith(
      bodyText2: light.bodyText2!.copyWith(
        fontFamily: "Nunito",
        color: darkGrey,
        fontSize: 14.0,
      ),
    );
  }
}
