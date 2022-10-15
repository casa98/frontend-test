import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  factory ApiService() => _instance;
  ApiService._internal();

  // Dio is too much for this basic usage, but let's keep it thinking of adding more features, uploading, downaloding images, etc.
  static final dio = Dio();
  static const uniqueUrl =
      'https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json';
  static const headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  // Make class Singleton, could go into Bloc too
  static final ApiService _instance = ApiService._internal();

  static Future<List<dynamic>> getUniversities() async {
    dio.options.headers = headers;
    final response = await dio.get(uniqueUrl);
    return response.data;
  }
}
