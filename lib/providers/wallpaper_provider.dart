import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/services/remote/api_calls.dart';


class WallpaperState {
  final List<Hit> wallpapers;
  final bool isInitialLoading;
  final bool isPaginating; 
  final String? error;

  const WallpaperState({
    this.wallpapers = const [],
    this.isInitialLoading = false,
    this.isPaginating = false,
    this.error,
  });


  WallpaperState copyWith({
    List<Hit>? wallpapers,
    bool? isInitialLoading,
    bool? isPaginating,
    String? error,
    bool clearError = false,
  }) {
    return WallpaperState(
      wallpapers: wallpapers ?? this.wallpapers,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isPaginating: isPaginating ?? this.isPaginating,
      error: clearError ? null : error ?? this.error,
    );
  }
}






class WallpaperNotifier extends Notifier<WallpaperState> {
   static int page = 1;
  @override
  WallpaperState build() {
    return WallpaperState();
  }

 
  Future<void> loadInitialWallpapers({trimmedQuery}) async {
    if (state.isInitialLoading) return;

    page = 1;
    state = state.copyWith(isInitialLoading: true, wallpapers: [], clearError: true);
    
    try {
      final newWallpapers = await ApiCalls().getAPI(page: page,trimmedQuery:trimmedQuery);
      state = state.copyWith(wallpapers: newWallpapers, isInitialLoading: false);
      page++;
    } catch (e) {
      state = state.copyWith(error: 'Failed to load wallpapers.', isInitialLoading: false);
    }
  }
  
  
  Future<void> loadMoreWallpapers() async {

    if (state.isInitialLoading || state.isPaginating) return;


    state = state.copyWith(isPaginating: true, clearError: true);

    try {
      final newWallpapers = await ApiCalls().getAPI(page: page);
      final allWallpapers = [...state.wallpapers, ...newWallpapers];
      
      state = state.copyWith(
        wallpapers: allWallpapers,
        isPaginating: false,
      );
      page++;
    } catch (e) {
      state = state.copyWith(error: 'Failed to load more.', isPaginating: false);
    }
  }








}

  


final wallpaperProvider = NotifierProvider<WallpaperNotifier, WallpaperState>(
  WallpaperNotifier.new,
);
