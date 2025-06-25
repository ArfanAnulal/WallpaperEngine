import 'package:flutter/material.dart';

class GridCardShimmer extends StatelessWidget {
  const GridCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
    );
  }
} 