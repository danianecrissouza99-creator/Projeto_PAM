import '../entities/game.dart';

abstract class GamesRepository {
  Future<List<Game>> getGames({
    String? search,
    String? ordering,
    String? genres,
    int page = 1,
  });
  Future<Game> getGameDetails(int id);
  Future<List<String>> getScreenshots(int id);
}
