import '../../../../core/usecases/usecase.dart';
import '../repositories/favorites_repository.dart';

/// Caso de uso: remover um jogo dos favoritos.
class RemoveFavorite implements UseCase<void, RemoveFavoriteParams> {
  final FavoritesRepository repository;
  RemoveFavorite(this.repository);

  @override
  Future<void> call(RemoveFavoriteParams params) {
    return repository.removeFavorite(params.userId, params.gameId);
  }
}

class RemoveFavoriteParams {
  final String userId;
  final int gameId;
  const RemoveFavoriteParams({required this.userId, required this.gameId});
}
