import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/utils/common_widgets/app_title_widget.dart';

// Views, downloads,  likes, comments,userimageurl,imagesize
class MoreDetailsCard extends StatefulWidget {
  const MoreDetailsCard({super.key, required this.hitDetails});
  final Hit hitDetails;

  @override
  State<MoreDetailsCard> createState() => _MoreDetailsCardState();
}

class _MoreDetailsCardState extends State<MoreDetailsCard> {
  late List<String> tags;
  @override
  void initState() {
    tags = (widget.hitDetails.tags ?? '').split(',');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag: 'app_title', child: const AppTitleWidget()),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await CachedNetworkImage.evictFromCache(
              widget.hitDetails.largeImageUrl!,
            );
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: widget.hitDetails.largeImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: const Color(0xFF000000),
                        highlightColor: Colors.grey[300]!,
                        child: Container(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Text('Details:', style: TextStyle(color: Colors.white)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: [
                      Chip(
                        label: Row(
                          spacing: 5,
                          children: [
                            CircleAvatar(
                              maxRadius: 10,
                              backgroundImage: NetworkImage(
                                widget.hitDetails.userImageUrl ??
                                    'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
                              ),
                            ),

                            Text(
                              '${widget.hitDetails.user}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Chip(
                        label: Text(
                          'Resolution: ${widget.hitDetails.imageWidth}x${widget.hitDetails.imageHeight}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Chip(
                        label: Text(
                          'Size: ${widget.hitDetails.imageSize}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Tags:', style: TextStyle(color: Colors.white)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: [
                      ...List.generate(tags.length, (index) {
                        return Chip(label: Text(tags[index].toString()));
                      }),
                    ],
                  ),
                ),
                Row(
                  spacing: 10,
                  children: [
                    Chip(
                      label: Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.comment),
                          Text('${widget.hitDetails.comments}'),
                        ],
                      ),
                    ),
                    Chip(
                      label: Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.favorite),
                          Text('${widget.hitDetails.likes}'),
                        ],
                      ),
                    ),
                    Chip(
                      label: Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.visibility),
                          Text('${widget.hitDetails.views}'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Chip(label: Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.download),
                          Text('${widget.hitDetails.downloads}')
                        ],
                      )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
