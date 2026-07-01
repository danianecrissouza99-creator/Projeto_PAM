import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_dcats/features/games/domain/entities/game.dart';
import 'package:game_dcats/features/games/domain/repositories/games_repository.dart';
import 'package:game_dcats/features/games/domain/usecases/get_games.dart';

/// Mock (versão falsa) do repositório, controlada pelo teste.
class MockGamesRepository extends Mock implements GamesRepository {}

void main() {
  late GetGames usecase;
  late MockGamesRepository mockRepository;

  setUp(() {
    mockRepository = MockGamesRepository();
    usecase = GetGames(mockRepository);
  });

  final tGames = [
    const Game(id: 1, name: 'Zelda', rating: 4.9),
    const Game(id: 2, name: 'Mario', rating: 4.7),
  ];

  test('deve devolver a lista de jogos vinda do repositório', () async {
    // arrange: preparamos o mock para devolver tGames quando chamado
    when(() => mockRepository.getGames(
          search: any(named: 'search'),
          ordering: any(named: 'ordering'),
          genres: any(named: 'genres'),
          page: any(named: 'page'),
        )).thenAnswer((_) async => tGames);

    // act: executamos o use case
    final result = await usecase(const GetGamesParams(search: 'zelda'));

    // assert: verificamos o resultado e que o repositório foi chamado certo
    expect(result, tGames);
    verify(() => mockRepository.getGames(
          search: 'zelda',
          ordering: null,
          genres: null,
          page: 1,
        )).called(1);
  });
}