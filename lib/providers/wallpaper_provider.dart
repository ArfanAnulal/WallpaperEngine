
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/services/remote/api_calls.dart';




class WallpaperNotifier extends Notifier<List<Hit>> {
  @override
  List<Hit> build(){
    return [];
  }


  Future<void> loadWallpaper({required int pages}) async {
    try {
      final List<Hit> newWallpapers = await ApiCalls().getAPI(page: pages);

      state = [...state, ...newWallpapers];
      

    } catch (e) {

      print('Error loading wallpapers: $e');
    }
  }
}

final  wallpaperProvider = NotifierProvider<WallpaperNotifier, List<Hit>>(
    WallpaperNotifier.new,
  );

