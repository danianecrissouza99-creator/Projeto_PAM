import '../entities/favorite_game.dart';

/// Contrato dos favoritos (camada de domínio).
abstract class FavoritesRepository {
  /// Lista de favoritos do utilizador, em tempo real (Stream).
  Stream<List<FavoriteGame>> watchFavorites(String userId);

  /// Adiciona um jogo aos favoritos.
  Future<void> addFavorite(String userId, FavoriteGame game);

  /// Remove um jogo dos favoritos (pelo id do jogo).
  Future<void> removeFavorite(String userId, int gameId);
}
