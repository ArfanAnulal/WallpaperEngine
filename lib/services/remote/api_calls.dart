import 'package:dio/dio.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/res/constants/app_constants.dart';

class ApiCalls {
  final _dio = Dio();
  final String _url = AppConstants.apiURL;
  Future<List<Hit>> getAPI() async{
    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['hits'];
        return data.map((json) => Hit.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts (Status code: ${response.statusCode})');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load posts: $e');
    }
}
}