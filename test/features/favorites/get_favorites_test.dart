import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_dcats/features/favorites/domain/entities/favorite_game.dart';
import 'package:game_dcats/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:game_dcats/features/favorites/domain/usecases/get_favorites.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late GetFavorites usecase;
  late MockFavoritesRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoritesRepository();
    usecase = GetFavorites(mockRepository);
  });

  const tUserId = 'user123';
  final tFavorites = [const FavoriteGame(id: 1, name: 'Zelda', rating: 4.9)];

  test('deve devolver o stream de favoritos do repositório', () {
    // arrange
    when(
      () => mockRepository.watchFavorites(tUserId),
    ).thenAnswer((_) => Stream.value(tFavorites));

    // act
    final result = usecase(tUserId);

    // assert
    expect(result, emits(tFavorites));
    verify(() => mockRepository.watchFavorites(tUserId)).called(1);
  });
}
