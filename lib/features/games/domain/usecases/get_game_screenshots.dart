import '../repositories/games_repository.dart';

/// Caso de uso: obter as screenshots de um jogo (2º endpoint GET da RAWG).
class GetGameScreenshots {
  const GetGameScreenshots(this._repository);
  final GamesRepository _repository;

  Future<List<String>> call(int id) => _repository.getScreenshots(id);
}