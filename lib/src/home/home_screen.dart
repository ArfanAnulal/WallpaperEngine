import 'package:flutter/material.dart';
import 'package:wallpaper_app/res/constants/app_constants.dart';
import 'package:wallpaper_app/utils/common_widgets.dart/app_title_widget.dart';
import 'package:wallpaper_app/utils/common_widgets.dart/top_cards.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});
  final topcardImages = AppConstants.topCards;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    
    return Scaffold(
      appBar: AppBar(
        title: const AppTitleWidget(),
        leading: Icon(Icons.account_circle),
        actions: [Icon(Icons.search)],
      ),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: width / 2),
            child: CarouselView.weighted(
              flexWeights: const <int>[100,100,100],
              scrollDirection: Axis.horizontal,
              // itemExtent: width,
              children:List.generate(topcardImages.length,(index){
                return TopCards(url: topcardImages[index]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}