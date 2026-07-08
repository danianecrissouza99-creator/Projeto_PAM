import '../repositories/favorites_repository.dart';

/// Caso de uso: remover um jogo dos favoritos.
class RemoveFavorite {
  const RemoveFavorite(this._repository);
  final FavoritesRepository _repository;

  Future<void> call(RemoveFavoriteParams params) {
    return _repository.removeFavorite(params.userId, params.gameId);
  }
}

class RemoveFavoriteParams {
  final String userId;
  final int gameId;
  const RemoveFavoriteParams({required this.userId, required this.gameId});
}