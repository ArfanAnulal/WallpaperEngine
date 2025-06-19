import 'package:flutter/material.dart';
import 'package:wallpaper_app/res/constants/string_constants.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.appName),
        leading: Icon(Icons.account_circle),
        actions: [Icon(Icons.search)],
      ),
    );
  }
}