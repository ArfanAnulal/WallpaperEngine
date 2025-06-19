
import 'package:flutter/material.dart';
import 'package:wallpaper_app/src/home/carousel_widget.dart';
import 'package:wallpaper_app/utils/common_widgets.dart/app_title_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const AppTitleWidget(),
        leading: Icon(Icons.account_circle),
        actions: [Icon(Icons.search)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: width/1.8,child:  const CarouselWidget()),
            Placeholder(),
            Placeholder(),
            Placeholder()
          ],
        ),
      )//adding column poses issue, prolly with height. fix that to add api called images below.
      );
  }
}
