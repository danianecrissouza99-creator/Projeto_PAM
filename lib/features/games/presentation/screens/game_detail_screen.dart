import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../favorites/domain/entities/favorite_game.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';
import '../providers/games_providers.dart';

class GameDetailScreen extends ConsumerWidget {
  final int gameId;
  const GameDetailScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(gameDetailsProvider(gameId));
    final favorites = ref.watch(favoritesStreamProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe'),
        actions: [
          gameAsync.maybeWhen(
            data: (game) {
              final isFav = favorites.any((f) => f.id == game.id);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                tooltip: isFav
                    ? 'Remover dos favoritos'
                    : 'Adicionar aos favoritos',
                onPressed: () {
                  final controller = ref.read(favoritesControllerProvider);
                  if (isFav) {
                    controller.remove(game.id);
                  } else {
                    controller.add(
                      FavoriteGame(
                        id: game.id,
                        name: game.name,
                        backgroundImage: game.backgroundImage,
                        rating: game.rating,
                      ),
                    );
                  }
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: gameAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Erro ao carregar o jogo.\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (game) => ListView(
          children: [
            if (game.backgroundImage != null)
              Image.network(
                game.backgroundImage!,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => const SizedBox(
                  height: 220,
                  child: Icon(Icons.videogame_asset, size: 64),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text('${game.rating.toStringAsFixed(1)} / 5'),
                      const SizedBox(width: 16),
                      if (game.released != null)
                        Text('Lançado: ${game.released}'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (game.genres.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: game.genres
                          .map((g) => Chip(label: Text(g)))
                          .toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
