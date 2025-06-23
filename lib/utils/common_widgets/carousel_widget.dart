import 'package:flutter/material.dart';
import 'package:wallpaper_app/res/constants/app_constants.dart';
import 'package:wallpaper_app/utils/common_widgets/top_cards.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final CarouselController controller = CarouselController(initialItem: 2);
  final List<String> urlsList = AppConstants.topCards;//list of url's

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
     final double width = MediaQuery.sizeOf(context).width;
    
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: width / 2),
      child: CarouselView.weighted(
        elevation: 5,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 5,right: 5),
        controller: controller,
        itemSnapping: true,
        flexWeights: const <int>[1,1, 10, 1,1],
        children:
            urlsList.map((String image) {
              return TopCards(imageInfo: image);
            }).toList(),
      ),
    );
  }
}