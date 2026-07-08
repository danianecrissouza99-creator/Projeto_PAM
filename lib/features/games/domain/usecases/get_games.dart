import '../entities/game.dart';
import '../repositories/games_repository.dart';

/// Caso de uso: obter / pesquisar / filtrar / ordenar jogos.
class GetGames {
  const GetGames(this._repository);
  final GamesRepository _repository;

  Future<List<Game>> call(GetGamesParams params) {
    return _repository.getGames(
      search: params.search,
      ordering: params.ordering,
      genres: params.genres,
      page: params.page,
    );
  }
}

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