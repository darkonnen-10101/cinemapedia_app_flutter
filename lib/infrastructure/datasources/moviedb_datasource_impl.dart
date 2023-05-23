import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/movidedb_response.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/movie_details.dart';
import 'package:dio/dio.dart';

class MovieDbDatasourceImpl extends MoviesDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieDbKey,
    'language': 'en-EN',
  }));

  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no poster')
        .map(
          (moviedb) => MovieMapper.movieDbToEntity(moviedb),
        )
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    const String url = '/movie/now_playing';

    final queryParameters = {'page': page};

    final response = await dio.get(url, queryParameters: queryParameters);

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    const String url = '/movie/popular';

    final queryParameters = {'page': page};

    final response = await dio.get(url, queryParameters: queryParameters);

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    const String url = '/movie/top_rated';

    final queryParameters = {'page': page};

    final response = await dio.get(url, queryParameters: queryParameters);

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    const String url = '/movie/upcoming';

    final queryParameters = {'page': page};

    final response = await dio.get(url, queryParameters: queryParameters);

    return _jsonToMovie(response.data);
  }

  @override
  Future<Movie> getMovieById(int id) async {
    final String url = '/movie/$id';

    final response = await dio.get(url);

    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final MovieDetails movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    const String url = '/search/movie';

    final queryParameters = {'query': query};

    final response = await dio.get(url, queryParameters: queryParameters);

    return _jsonToMovie(response.data);
  }
}
