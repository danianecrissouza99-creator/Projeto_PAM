import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/game.dart';
import '../../domain/repositories/games_repository.dart';
import '../../domain/usecases/get_games.dart';
import '../../domain/usecases/get_game_details.dart';
import '../../data/datasources/games_remote_data_source.dart';
import '../../data/repositories/games_repository_impl.dart';

// ============ Ligação das dependências (data -> domain) ============

final gamesRemoteDataSourceProvider = Provider<GamesRemoteDataSource>((ref) {
  return GamesRemoteDataSourceImpl(ref.watch(dioProvider));
});

final gamesRepositoryProvider = Provider<GamesRepository>((ref) {
  return GamesRepositoryImpl(ref.watch(gamesRemoteDataSourceProvider));
});

final getGamesProvider = Provider<GetGames>((ref) {
  return GetGames(ref.watch(gamesRepositoryProvider));
});

final getGameDetailsProvider = Provider<GetGameDetails>((ref) {
  return GetGameDetails(ref.watch(gamesRepositoryProvider));
});

// ============ Estado da pesquisa / filtro / ordenação ============

class GamesQuery {
  final String search;
  final String? ordering;
  final String? genres;

  const GamesQuery({this.search = '', this.ordering, this.genres});
}

class GamesQueryNotifier extends Notifier<GamesQuery> {
  @override
  GamesQuery build() => const GamesQuery();

  void setSearch(String value) {
    state = GamesQuery(search: value, ordering: state.ordering, genres: state.genres);
  }

  void setOrdering(String? value) {
    state = GamesQuery(search: state.search, ordering: value, genres: state.genres);
  }

  void setGenres(String? value) {
    state = GamesQuery(search: state.search, ordering: state.ordering, genres: value);
  }
}

final gamesQueryProvider =
    NotifierProvider<GamesQueryNotifier, GamesQuery>(GamesQueryNotifier.new);

// ============ A lista de jogos (reage à query acima) ============

final gamesListProvider = FutureProvider.autoDispose<List<Game>>((ref) async {
  final query = ref.watch(gamesQueryProvider);
  final getGames = ref.watch(getGamesProvider);
  return getGames(
    GetGamesParams(
      search: query.search,
      ordering: query.ordering,
      genres: query.genres,
    ),
  );
});