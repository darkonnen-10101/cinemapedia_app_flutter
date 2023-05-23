import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';
import '../../types/movies_callback.dart';
import '../providers.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<int, List<Actor>>>((ref) {
  final actorsRepostory = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepostory.getActorsByMovie);
});

/* ****** Caché local
  {
    '505642': Movie(),
    '505643': Movie(),
    '505645': Movie(),
    '501231': Movie(),
  }
*/

class ActorsByMovieNotifier extends StateNotifier<Map<int, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
