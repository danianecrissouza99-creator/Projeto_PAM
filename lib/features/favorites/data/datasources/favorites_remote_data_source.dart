import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/favorite_game_model.dart';

abstract class FavoritesRemoteDataSource {
  Stream<List<FavoriteGameModel>> watchFavorites(String userId);
  Future<void> addFavorite(String userId, FavoriteGameModel game);
  Future<void> removeFavorite(String userId, int gameId);
}

/// Implementação que usa o Cloud Firestore.
class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final FirebaseFirestore firestore;
  FavoritesRemoteDataSourceImpl(this.firestore);

  /// Atalho para a coleção users/{userId}/favorites
  CollectionReference<Map<String, dynamic>> _favoritesRef(String userId) {
    return firestore.collection('users').doc(userId).collection('favorites');
  }

  @override
  Stream<List<FavoriteGameModel>> watchFavorites(String userId) {
    return _favoritesRef(userId).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FavoriteGameModel.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> addFavorite(String userId, FavoriteGameModel game) {
    // Usa o id do jogo como id do documento -> evita duplicados
    return _favoritesRef(userId).doc(game.id.toString()).set(game.toMap());
  }

  @override
  Future<void> removeFavorite(String userId, int gameId) {
    return _favoritesRef(userId).doc(gameId.toString()).delete();
  }
}
