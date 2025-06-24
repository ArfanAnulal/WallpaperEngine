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
      () => ref.read(wallpaperProvider.notifier).loadWallpaper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final finalwallpapers = ref.watch(wallpaperProvider);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisExtent: 270,
        mainAxisSpacing: 10,
      ),
      itemCount: finalwallpapers.length,
      itemBuilder: (context, index) {
        final hit = finalwallpapers[index];
        return GridCards(hitDetails: hit);
      },
    );
  }
}
