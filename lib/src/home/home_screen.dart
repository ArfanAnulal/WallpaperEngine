
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/utils/common_widgets/carousel_widget.dart';
import 'package:wallpaper_app/utils/common_widgets/app_title_widget.dart';
import 'package:wallpaper_app/utils/common_widgets/grid_builder.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const AppTitleWidget(),
        leading: Icon(Icons.account_circle),
        actions: [Icon(Icons.search)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: width/2,child:  const CarouselWidget()),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsetsGeometry.only(bottom: 20),child: GridBuilder()),
              ElevatedButton(onPressed: (){ref.read(wallpaperProvider.notifier).loadWallpaper();}, child: Text('Load More!')),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
      );
  }
}
