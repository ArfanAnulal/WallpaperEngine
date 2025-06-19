import 'package:flutter/material.dart';
import 'package:wallpaper_app/res/styles/color_palette.dart';
import 'font_palette.dart';

class AppTheme {
  static final  lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: ColorPalette.appBarColor,
      centerTitle: true,
      toolbarHeight: 80,
      titleTextStyle: TextStyle(fontFamily: 'NoyhR', fontSize: 32, fontWeight: FontWeight.bold, color: FontPalette.appBarTextSecondHalfColor),
      actionsPadding: EdgeInsets.all(8),
      actionsIconTheme: IconThemeData(
        size: 35,
        color: ColorPalette.iconColor,
      ),iconTheme: IconThemeData(
        size: 40,color:  ColorPalette.appBarLeadingColor
      )
    ),
    scaffoldBackgroundColor: ColorPalette.scaffoldColor,












    //----TEXT THEMES----//
    textTheme:  TextTheme(
    displaySmall: TextStyle(
      color: FontPalette.normalTextColor
    )
  )
  );
  
}