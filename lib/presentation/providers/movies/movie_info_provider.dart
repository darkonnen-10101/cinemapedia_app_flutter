import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../types/movies_callback.dart';
import '../providers.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<int, Movie>>((ref) {
  final movieRepostory = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: movieRepostory.getMovieById);
});

/* ****** Caché local
  {
    '505642': Movie(),
    '505643': Movie(),
    '505645': Movie(),
    '501231': Movie(),
  }
*/

class MovieMapNotifier extends StateNotifier<Map<int, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(int movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
