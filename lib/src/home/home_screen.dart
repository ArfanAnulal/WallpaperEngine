
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/utils/common_functions/custom_search_delegate.dart';
import 'package:wallpaper_app/utils/common_widgets/carousel_widget.dart';
import 'package:wallpaper_app/utils/common_widgets/app_title_widget.dart';
import 'package:wallpaper_app/utils/common_widgets/grid_builder.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(wallpaperProvider.notifier).loadMoreWallpapers();
    }
  }
  @override
  Widget build(BuildContext context) {
    final wallpaperState = ref.watch(wallpaperProvider);
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const AppTitleWidget(),
        leading: Icon(Icons.account_circle),
        actions: [IconButton(icon:Icon(Icons.search), onPressed:(){showSearch(
                context: context,
                delegate: CustomSearchDelegate(ref: ref),
              );} ,)],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(wallpaperProvider.notifier).loadInitialWallpapers();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: width/2,child:  const CarouselWidget()),
                SizedBox(height: 20,),
                Padding(padding: EdgeInsetsGeometry.only(bottom: 20),child: GridBuilder()),
                if (wallpaperState.isPaginating)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  
              ],
            ),
          ),
        ),
      ),
      );
  }
}
