import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/favorite_game.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../domain/usecases/add_favorite.dart';
import '../../domain/usecases/remove_favorite.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../data/datasources/favorites_remote_data_source.dart';
import '../../data/repositories/favorites_repository_impl.dart';

// ===== Ligação das dependências =====
final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final favoritesRemoteDataSourceProvider = Provider<FavoritesRemoteDataSource>((
  ref,
) {
  return FavoritesRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl(ref.watch(favoritesRemoteDataSourceProvider));
});

final addFavoriteProvider = Provider<AddFavorite>(
  (ref) => AddFavorite(ref.watch(favoritesRepositoryProvider)),
);
final removeFavoriteProvider = Provider<RemoveFavorite>(
  (ref) => RemoveFavorite(ref.watch(favoritesRepositoryProvider)),
);
final getFavoritesProvider = Provider<GetFavorites>(
  (ref) => GetFavorites(ref.watch(favoritesRepositoryProvider)),
);

// ===== Lista de favoritos do utilizador atual (tempo real) =====
final favoritesStreamProvider = StreamProvider.autoDispose<List<FavoriteGame>>((
  ref,
) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) {
    return Stream.value(const <FavoriteGame>[]);
  }
  return ref.watch(getFavoritesProvider)(user.uid);
});

// ===== Ações: adicionar / remover =====
class FavoritesController {
  final Ref ref;
  FavoritesController(this.ref);

  Future<void> add(FavoriteGame game) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    await ref.read(addFavoriteProvider)(
      AddFavoriteParams(userId: user.uid, game: game),
    );
  }

  Future<void> remove(int gameId) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    await ref.read(removeFavoriteProvider)(
      RemoveFavoriteParams(userId: user.uid, gameId: gameId),
    );
  }
}

final favoritesControllerProvider = Provider<FavoritesController>(
  (ref) => FavoritesController(ref),
);
