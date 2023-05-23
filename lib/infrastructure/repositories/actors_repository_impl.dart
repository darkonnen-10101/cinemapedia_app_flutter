import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/domain/repositories/actors_repository.dart';
import '../../domain/datasources/actors_datasource.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorMovieDbDatasourceImpl;

  ActorsRepositoryImpl(this.actorMovieDbDatasourceImpl);

  @override
  Future<List<Actor>> getActorsByMovie(int movieId) {
    return actorMovieDbDatasourceImpl.getActorsByMovie(movieId);
  }
}
