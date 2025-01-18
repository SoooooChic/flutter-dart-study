import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/models/movie_detail_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  ///  "popular",
  ///  "now-playing",
  ///  "coming-soon",
  static Future<List<MovieModel>> getMovies(String movieType) async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$movieType');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body);
      for (var movie in movies['results']) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(String id) async {
    final url = Uri.parse("$baseUrl/movie?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
