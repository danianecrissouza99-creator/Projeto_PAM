import '../../../../core/usecases/usecase.dart';
import '../repositories/games_repository.dart';

/// Caso de uso: obter as screenshots de um jogo (2º endpoint GET da RAWG).
class GetGameScreenshots implements UseCase<List<String>, int> {
  final GamesRepository repository;
  GetGameScreenshots(this.repository);

  @override
  Future<List<String>> call(int id) {
    return repository.getScreenshots(id);
  }
}
