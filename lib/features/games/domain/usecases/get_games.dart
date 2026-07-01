import '../../../../core/usecases/usecase.dart';
import '../entities/game.dart';
import '../repositories/games_repository.dart';

/// Caso de uso: obter / pesquisar / filtrar / ordenar jogos.
class GetGames implements UseCase<List<Game>, GetGamesParams> {
  final GamesRepository repository;
  GetGames(this.repository);

  @override
  Future<List<Game>> call(GetGamesParams params) {
    return repository.getGames(
      search: params.search,
      ordering: params.ordering,
      genres: params.genres,
      page: params.page,
    );
  }
}

/// Os dados de entrada do caso de uso (juntos num só objeto).
class GetGamesParams {
  final String? search;
  final String? ordering;
  final String? genres;
  final int page;

  const GetGamesParams({
    this.search,
    this.ordering,
    this.genres,
    this.page = 1,
  });
}