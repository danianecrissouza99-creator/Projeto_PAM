import '../entities/favorite_game.dart';
import '../repositories/favorites_repository.dart';

/// Caso de uso: obter os favoritos do utilizador em tempo real.
class GetFavorites {
  final FavoritesRepository repository;
  GetFavorites(this.repository);

  Stream<List<FavoriteGame>> call(String userId) {
    return repository.watchFavorites(userId);
  }
}
