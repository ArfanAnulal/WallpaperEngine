import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/utils/common_widgets/app_title_widget.dart';


class MoreDetailsCard extends StatefulWidget {
  const MoreDetailsCard({super.key, required this.hitDetails});
  final Hit hitDetails;

  @override
  State<MoreDetailsCard> createState() => _MoreDetailsCardState();
}

class _MoreDetailsCardState extends State<MoreDetailsCard> {
  late List<String> tags;

  bool _isDownloading = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    tags = (widget.hitDetails.tags ?? '').split(',');
  }

  Future<void> _downloadAndSaveToGallery(String url, BuildContext context) async {
  var status = await Permission.photos.request();
  if (!status.isGranted) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo library permission is required.')),
      );
    }
    return;
  }

  setState(() {
    _isDownloading = true;
    _progress = 0.0;
  });

  try {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    
    await Dio().download(
      url,
      tempPath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          setState(() {
            _progress = received / total;
          });
        }
      },
    );

    final mediaStore = MediaStore();
    final Directory appDir = await getApplicationDocumentsDirectory();
    MediaStore.appFolder = appDir.toString();
    await MediaStore.ensureInitialized();
    
    await mediaStore.saveFile(
        tempFilePath: tempPath,
        dirType: DirType.photo, 
        dirName: DirName.pictures, 
        relativePath: "Wallpaper Engine", 
    );


    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved to Gallery!')),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  } finally {
    setState(() {
      _isDownloading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Hero(tag: 'app_title', child: AppTitleWidget()),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await CachedNetworkImage.evictFromCache(
              widget.hitDetails.largeImageUrl!,
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: widget.hitDetails.largeImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[600]!,
                        child: Container(color: Colors.black),
                      ),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error, color: Colors.red)),
                    ),
                  ),
                ),
                const Text('Details:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),


                Wrap(
                  spacing: 10.0, 
                  runSpacing: 10.0, 
                  children: [
                    Chip(
                      avatar: CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.hitDetails.userImageUrl ??
                              'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
                        ),
                      ),
                      label: Text(widget.hitDetails.user ?? 'N/A'),
                    ),
                    Chip(
                      label: Text(
                          'Resolution: ${widget.hitDetails.imageWidth}x${widget.hitDetails.imageHeight}'),
                    ),
                    Chip(
                      label:
                          Text('Size: ${(widget.hitDetails.imageSize! / 1000000).toStringAsFixed(2)} MB'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Tags:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(tags.length, (index) {
                    return Chip(
                      label: Text(tags[index].trim()),
                      backgroundColor: Colors.grey.shade700,
                      labelStyle: const TextStyle(color: Colors.white),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                const Text('Stats:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    Chip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.comment, size: 18),
                          const SizedBox(width: 5),
                          Text('${widget.hitDetails.comments}'),
                        ],
                      ),
                    ),
                    Chip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.favorite, size: 18, color: Colors.pink),
                          const SizedBox(width: 5),
                          Text('${widget.hitDetails.likes}'),
                        ],
                      ),
                    ),
                    Chip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.visibility, size: 18, color: Colors.blue),
                          const SizedBox(width: 5),
                          Text('${widget.hitDetails.views}'),
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: _isDownloading
                          ? null 
                          : () => _downloadAndSaveToGallery(
                              widget.hitDetails.largeImageUrl!, context),
                      borderRadius: BorderRadius.circular(20.0),
                      child: Chip(
                        backgroundColor: Colors.green,
                        label: _isDownloading
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      value: _progress > 0 ? _progress : null,
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${(_progress * 100).toStringAsFixed(0)}%',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.download, size: 18, color: Colors.white),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${widget.hitDetails.downloads}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
