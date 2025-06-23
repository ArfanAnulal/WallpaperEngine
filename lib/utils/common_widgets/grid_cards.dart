import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridCards extends StatefulWidget {
  const GridCards({super.key, required this.hitDetails});
  final Hit hitDetails;

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
              imageUrl: widget.hitDetails.largeImageUrl!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.blue[300]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            ),
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            color: const Color(0xFF032630),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [

                    Text(
                      widget.hitDetails.user.toString(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 10),
                    ),

                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.favorite_border,color: Colors.white,  size: 25),
                    const SizedBox(width: 6),
                    Text(
                      widget.hitDetails.likes.toString(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}
