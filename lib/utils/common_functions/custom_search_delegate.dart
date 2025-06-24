import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';

class CustomSearchDelegate extends SearchDelegate<String> {

  final WidgetRef ref;

  CustomSearchDelegate({required this.ref});


  @override
  String get searchFieldLabel => 'Search for wallpapers...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isNotEmpty) {

      WidgetsBinding.instance.addPostFrameCallback((_) {

        ref.read(wallpaperProvider.notifier).loadInitialWallpapers(trimmedQuery: trimmedQuery);

        close(context, trimmedQuery);
      });
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {

    return Text('Buildings');
  }
}
