import '../entities/favorite_game.dart';
import '../repositories/favorites_repository.dart';

/// Caso de uso: adicionar um jogo aos favoritos.
class AddFavorite {
  const AddFavorite(this._repository);
  final FavoritesRepository _repository;

  Future<void> call(AddFavoriteParams params) {
    return _repository.addFavorite(params.userId, params.game);
  }
}

class AddFavoriteParams {
  final String userId;
  final FavoriteGame game;
  const AddFavoriteParams({required this.userId, required this.game});
}