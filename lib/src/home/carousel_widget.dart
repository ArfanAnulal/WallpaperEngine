import 'package:flutter/material.dart';
import 'package:wallpaper_app/res/constants/app_constants.dart';
import 'package:wallpaper_app/utils/common_widgets.dart/top_cards.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final topcardImages = AppConstants.topCards;
  final CarouselController controller = CarouselController(initialItem: 1);
  final List<String> urlss = AppConstants.topCards;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final double width = MediaQuery.sizeOf(context).width;
    
    return ListView(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: width / 2),
          child: CarouselView.weighted(
            controller: controller,
            itemSnapping: true,
            flexWeights: const <int>[1, 7, 1],
            children:
                urlss.map((String image) {
                  return TopCards(imageInfo: image);
                }).toList(),
          ),
        ),
        ],
      );
  }
}