import 'package:flutter/material.dart';

class GridBuilder extends StatelessWidget {
  const GridBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index){
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Placeholder()
      );
      }
    );
  }
}
