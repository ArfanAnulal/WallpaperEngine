import 'package:flutter/material.dart';

class TopCards extends StatelessWidget {
  const TopCards({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: Image.network(url, fit: BoxFit.cover)),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text('Trending Nodw'),
          ),
        ],
      ),
    );
  }
}
