import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/utils/common_widgets/grid_cards.dart';

class GridBuilder extends ConsumerStatefulWidget {
  const GridBuilder({super.key});

  @override
  ConsumerState<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends ConsumerState<GridBuilder> {

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(wallpaperProvider.notifier).loadInitialWallpapers(),
    );
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<WallpaperState>(wallpaperProvider, (previous, next) {
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: WallpaperNotifier.page>=11?Text("You've seen all images!", style: TextStyle(fontWeight: FontWeight.bold),):Text(next.error!+"\nTry restarting the app and checking your internet", style: TextStyle(fontWeight: FontWeight.bold),),
            backgroundColor: WallpaperNotifier.page>=11?const Color(0xFFEED202):Colors.redAccent,
          ),
        );
      }
    });




    final finalwallpapers = ref.watch(wallpaperProvider);
    if (finalwallpapers.isInitialLoading ){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else{
      return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisExtent: 270,
        mainAxisSpacing: 10,
      ),
      itemCount: finalwallpapers.wallpapers.length,
      itemBuilder: (context, index) {
        final hit = finalwallpapers.wallpapers[index];
        return GridCards(hitDetails: hit);
      },
    );
    }
    
  }
}
