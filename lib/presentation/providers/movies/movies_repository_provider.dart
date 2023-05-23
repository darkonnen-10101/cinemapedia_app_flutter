import 'package:cinemapedia_app/infrastructure/datasources/moviedb_datasource_impl.dart';
import 'package:cinemapedia_app/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(MovieDbDatasourceImpl());
});
