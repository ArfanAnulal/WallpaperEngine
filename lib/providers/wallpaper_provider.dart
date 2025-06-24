
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/services/remote/api_calls.dart';




class WallpaperNotifier extends Notifier<List<Hit>> {
  @override
  List<Hit> build(){
    return [];
  }

  int pages = 1;
  Future<void> loadWallpaper() async {

    try {
      final List<Hit> newWallpapers = await ApiCalls().getAPI(page: pages);
      state = [...state, ...newWallpapers];
      pages++;
      

    } catch (e) {

      print('Error loading wallpapers: $e');
    }
  }
}

final  wallpaperProvider = NotifierProvider<WallpaperNotifier, List<Hit>>(
    WallpaperNotifier.new,
  );

