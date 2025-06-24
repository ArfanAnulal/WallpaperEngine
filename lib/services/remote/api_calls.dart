import 'package:dio/dio.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/res/constants/app_constants.dart';

class ApiCalls {
  final _dio = Dio();
  
  Future<List<Hit>> getAPI({required int page, query='nature'}) async{
    final String url = '${AppConstants.apiURL}&page=$page&q=$query';
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final basicData = Basicdata.fromJson(response.data);
        return basicData.hits!;
      } else {
        throw Exception('Failed to load posts (Status code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
}
}