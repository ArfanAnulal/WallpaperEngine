import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';

class GridCards extends StatefulWidget {
  const GridCards({super.key, required this.hitDetails});
  final Hit hitDetails;

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Image.network(widget.hitDetails.previewUrl!)
                          );
  }
}