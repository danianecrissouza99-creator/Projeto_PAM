import '../../../../core/usecases/usecase.dart';
import '../entities/game.dart';
import '../repositories/games_repository.dart';

/// Caso de uso: obter os detalhes de um jogo pelo seu id.
class GetGameDetails implements UseCase<Game, int> {
  final GamesRepository repository;
  GetGameDetails(this.repository);

  @override
  Future<Game> call(int id) {
    return repository.getGameDetails(id);
  }
}