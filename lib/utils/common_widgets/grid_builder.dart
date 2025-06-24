import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/utils/common_widgets/grid_cards.dart';
import 'package:wallpaper_app/utils/common_widgets/shimmer_grid.dart';

class GridBuilder extends ConsumerStatefulWidget {
  const GridBuilder({super.key});

  @override
  ConsumerState<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends ConsumerState<GridBuilder> {
  late Future<List<Hit>> _futureHits;

  @override
  void initState() {
    super.initState();
    Future.microtask (() => ref.read(wallpaperProvider.notifier).loadWallpaper(pages:1));
  }

  @override
  Widget build(BuildContext context) {
  
    return FutureBuilder<List<Hit>>(
      future: _futureHits, 
      builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting ){
              return const ShimmerGrid();
            }
            else if(snapshot.hasData){
              final hits = snapshot.data!;
              return GridView.builder(
    
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 270,
                  mainAxisSpacing: 10
    
                ),
                itemCount: hits.length,
                itemBuilder: (context, index){
                  final hit = hits[index];
                  return GridCards(hitDetails:hit);
                }
              );
              }
              else{
              return const Text('No posts found.');
            }
        },
      );
  }
}
