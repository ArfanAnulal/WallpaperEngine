import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/topcarddata.dart';
import 'package:wallpaper_app/res/constants/app_constants.dart';
import 'package:wallpaper_app/utils/common_widgets/top_cards.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final CarouselController controller = CarouselController(initialItem: 2);
  final List<TopCardData> urlsList = AppConstants.topCards;//list of TopCardData

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    
    return CarouselSlider(
  options: CarouselOptions(
    height: 200, 
    autoPlay: true,
    enlargeCenterPage: true,
    viewportFraction: 0.8,
  ),
  items: urlsList.map((topCardData) {
    return TopCards(topCardInfo: topCardData);
  }).toList(),

  );
  }

  
}