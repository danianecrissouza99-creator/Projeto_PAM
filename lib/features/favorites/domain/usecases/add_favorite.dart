import '../../../../core/usecases/usecase.dart';
import '../entities/favorite_game.dart';
import '../repositories/favorites_repository.dart';

/// Caso de uso: adicionar um jogo aos favoritos.
class AddFavorite implements UseCase<void, AddFavoriteParams> {
  final FavoritesRepository repository;
  AddFavorite(this.repository);

  @override
  Future<void> call(AddFavoriteParams params) {
    return repository.addFavorite(params.userId, params.game);
  }
}

class AddFavoriteParams {
  final String userId;
  final FavoriteGame game;
  const AddFavoriteParams({required this.userId, required this.game});
}
