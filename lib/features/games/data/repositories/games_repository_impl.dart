import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/game.dart';
import '../../domain/repositories/games_repository.dart';
import '../datasources/games_remote_data_source.dart';

/// Implementação do contrato GamesRepository (camada de dados).
/// Usa o datasource para obter os dados e converte exceções em falhas.
class GamesRepositoryImpl implements GamesRepository {
  final GamesRemoteDataSource remoteDataSource;
  GamesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Game>> getGames({
    String? search,
    String? ordering,
    String? genres,
    int page = 1,
  }) async {
    try {
      return await remoteDataSource.getGames(
        search: search,
        ordering: ordering,
        genres: genres,
        page: page,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }

  @override
  Future<Game> getGameDetails(int id) async {
    try {
      return await remoteDataSource.getGameDetails(id);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }
}