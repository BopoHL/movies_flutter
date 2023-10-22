import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_flutter/domain/models/movie_list.dart';
import '../models/movie.dart';

abstract class Api {
  static final _apiKey = dotenv.get('API_KEY');
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const _language = 'ru-RU';

  static final Dio _dio = Dio(
    BaseOptions(
        baseUrl: _baseUrl,
        queryParameters: {'api_key': _apiKey, 'language': _language}),
  );

  static Future<MovieList> getPopularMovies() async {
    final response = await _dio.get('/movie/popular');
    if (response.statusCode == 200) {
      final result = MovieList.fromJson(response.data);
      return result;
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  static Future<Movie> getMovieInfo(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      final result = Movie.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  static Future<MovieList> searchMovies(String query) async {
    try {
      final response =
          await _dio.get("/search/movie", queryParameters: {'query': query});
      final result = MovieList.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
