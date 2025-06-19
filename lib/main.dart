import 'package:flutter/material.dart';
import 'package:wallpaper_app/res/constants/string_constants.dart';
import 'package:wallpaper_app/res/styles/theme.dart';
import 'package:wallpaper_app/src/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
      
    );
  }
}

