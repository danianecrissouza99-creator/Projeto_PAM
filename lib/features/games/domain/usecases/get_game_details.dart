import '../entities/game.dart';
import '../repositories/games_repository.dart';

/// Caso de uso: obter os detalhes de um jogo pelo seu id.
class GetGameDetails {
  const GetGameDetails(this._repository);
  final GamesRepository _repository;

  Future<Game> call(int id) => _repository.getGameDetails(id);
}