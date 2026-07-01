import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/games_providers.dart';
import '../widgets/game_card.dart';
import 'game_detail_screen.dart';


class GamesListScreen extends ConsumerStatefulWidget {
  const GamesListScreen({super.key});

  @override
  ConsumerState<GamesListScreen> createState() => _GamesListScreenState();
}

class _GamesListScreenState extends ConsumerState<GamesListScreen> {
  final _searchController = TextEditingController();

  // Ordenação: texto mostrado -> valor que a RAWG entende
  static const _orderings = {
    'Relevância': null,
    'Melhor avaliados': '-rating',
    'Mais recentes': '-released',
    'Nome (A-Z)': 'name',
  };

  // Género (filtro): texto mostrado -> slug da RAWG
  static const _genres = {
    'Todos': null,
    'Ação': 'action',
    'Aventura': 'adventure',
    'RPG': 'role-playing-games-rpg',
    'Estratégia': 'strategy',
    'Shooter': 'shooter',
    'Puzzle': 'puzzle',
    'Indie': 'indie',
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(gamesQueryProvider);
    final gamesAsync = ref.watch(gamesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('GameVault')),
      body: Column(
        children: [
          // Pesquisa
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar jogos...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) =>
                  ref.read(gamesQueryProvider.notifier).setSearch(value),
            ),
          ),
          // Ordenação + Filtro
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String?>(
                    initialValue: query.ordering,
                    decoration: const InputDecoration(
                      labelText: 'Ordenar',
                      border: OutlineInputBorder(),
                    ),
                    items: _orderings.entries
                        .map((e) => DropdownMenuItem(
                            value: e.value, child: Text(e.key)))
                        .toList(),
                    onChanged: (value) =>
                        ref.read(gamesQueryProvider.notifier).setOrdering(value),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String?>(
                    initialValue: query.genres,
                    decoration: const InputDecoration(
                      labelText: 'Género',
                      border: OutlineInputBorder(),
                    ),
                    items: _genres.entries
                        .map((e) => DropdownMenuItem(
                            value: e.value, child: Text(e.key)))
                        .toList(),
                    onChanged: (value) =>
                        ref.read(gamesQueryProvider.notifier).setGenres(value),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Resultados
          Expanded(
            child: gamesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Erro ao carregar jogos.\n$error',
                      textAlign: TextAlign.center),
                ),
              ),
              data: (games) {
                if (games.isEmpty) {
                  return const Center(child: Text('Nenhum jogo encontrado.'));
                }
                return ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) 
                  {
                      final game = games[index];
                      return GameCard(
                        game: game,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GameDetailScreen(gameId: game.id),
                            ),
                          );
                        },
                      );
                },                );
              },
            ),
          ),
        ],
      ),
    );
  }
}