import '../../domain/entities/favorite_game.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_data_source.dart';
import '../models/favorite_game_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;
  FavoritesRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<FavoriteGame>> watchFavorites(String userId) {
    return remoteDataSource.watchFavorites(userId);
  }

  @override
  Future<void> addFavorite(String userId, FavoriteGame game) {
    return remoteDataSource.addFavorite(
      userId,
      FavoriteGameModel.fromEntity(game),
    );
  }

  @override
  Future<void> removeFavorite(String userId, int gameId) {
    return remoteDataSource.removeFavorite(userId, gameId);
  }
}
