import '../entities/game.dart';

/// Contrato da camada de DOMÍNIO: define O QUE se pode fazer com jogos.
/// O "como" (chamar a RAWG) fica na implementação, na camada de dados.
abstract class GamesRepository {
  /// Lista e pesquisa jogos. Todos os parâmetros são opcionais.
  /// [search]   - termo de pesquisa (ex.: "zelda")
  /// [ordering] - ordenação (ex.: "-rating" para melhor avaliados primeiro)
  /// [genres]   - filtrar por género (ex.: "action")
  /// [page]     - número da página (paginação)
  Future<List<Game>> getGames({
    String? search,
    String? ordering,
    String? genres,
    int page = 1,
  });

  /// Detalhes de um jogo específico (pelo seu id).
  Future<Game> getGameDetails(int id);
}