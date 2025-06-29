import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/topcarddata.dart';

class TopCards extends StatelessWidget {
  const TopCards({super.key, required this.topCardInfo});

  final TopCardData topCardInfo;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: OverflowBox(
            maxWidth: width * 10 / 6,
            minWidth: width * 10 / 6,
            child: CachedNetworkImage(
              imageUrl: topCardInfo.url,
              fit: BoxFit.cover,
    
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                topCardInfo.heading,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontFamily: 'NoyhR',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                topCardInfo.subheading,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontFamily: 'NoyhR',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
