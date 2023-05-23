import '../../domain/entities/actor.dart';
import '../../domain/entities/movie.dart';

typedef MovieCallback = Future<List<Movie>> Function({int page});

typedef GetMovieCallback = Future<Movie> Function(int movieId);

typedef GetActorsCallback = Future<List<Actor>> Function(int movieId);

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);
