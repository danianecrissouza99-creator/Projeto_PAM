import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_dcats/features/favorites/domain/entities/favorite_game.dart';
import 'package:game_dcats/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:game_dcats/features/favorites/domain/usecases/add_favorite.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

/// Necessário para o mocktail lidar com o tipo FavoriteGame no any()
class FakeFavoriteGame extends Fake implements FavoriteGame {}

void main() {
  late AddFavorite usecase;
  late MockFavoritesRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeFavoriteGame());
  });

  setUp(() {
    mockRepository = MockFavoritesRepository();
    usecase = AddFavorite(mockRepository);
  });

  const tUserId = 'user123';
  const tGame = FavoriteGame(id: 1, name: 'Zelda', rating: 4.9);

  test(
    'deve pedir ao repositório para adicionar o jogo aos favoritos',
    () async {
      // arrange
      when(
        () => mockRepository.addFavorite(any(), any()),
      ).thenAnswer((_) async {});

      // act
      await usecase(const AddFavoriteParams(userId: tUserId, game: tGame));

      // assert
      verify(() => mockRepository.addFavorite(tUserId, tGame)).called(1);
    },
  );
}
