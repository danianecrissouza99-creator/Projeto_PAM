import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../favorites/domain/entities/favorite_game.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';
import '../providers/games_providers.dart';

class GameDetailScreen extends ConsumerWidget {
  final int gameId;
  const GameDetailScreen({super.key, required this.gameId});

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(gameDetailsProvider(gameId));
    final theme = Theme.of(context);

    return Scaffold(
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
        data: (game) {
          final favorites =
              ref.watch(favoritesStreamProvider).value ?? const [];
          final isFav = favorites.any((f) => f.id == game.id);
          final shotsAsync = ref.watch(gameScreenshotsProvider(gameId));

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                actions: [
                  IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : null,
                    ),
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
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    game.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (game.backgroundImage != null)
                        Image.network(
                          game.backgroundImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => const ColoredBox(
                            color: Colors.black26,
                            child: Icon(Icons.videogame_asset, size: 64),
                          ),
                        )
                      else
                        const ColoredBox(color: Colors.black26),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              _RatingBadge(rating: game.rating),
                              if (game.metacritic != null)
                                _MetacriticBadge(score: game.metacritic!),
                              if (game.released != null)
                                Text(
                                  'Lançado: ${game.released}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                            ],
                          ),
                          if (game.platforms.isNotEmpty) ...[
                            const SizedBox(height: 18),
                            Text(
                              'Plataformas',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: game.platforms
                                  .map((p) => Chip(label: Text(p)))
                                  .toList(),
                            ),
                          ],
                          if (game.genres.isNotEmpty) ...[
                            const SizedBox(height: 18),
                            Text(
                              'Géneros',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: game.genres
                                  .map(
                                    (g) => Chip(
                                      label: Text(g),
                                      backgroundColor: theme.colorScheme.primary
                                          .withValues(alpha: 0.15),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                          const SizedBox(height: 18),
                          Text(
                            'Imagens',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 150,
                            child: shotsAsync.when(
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (e, s) =>
                                  const Text('Sem imagens disponíveis.'),
                              data: (shots) {
                                if (shots.isEmpty) {
                                  return const Text('Sem imagens disponíveis.');
                                }
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: shots.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      shots[index],
                                      width: 240,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) =>
                                          const SizedBox(width: 240),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (game.description != null &&
                              game.description!.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            Text(
                              'Sobre',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              game.description!,
                              style: const TextStyle(height: 1.5),
                            ),
                          ],
                          if (game.stores.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            Text(
                              'Onde comprar',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: game.stores
                                  .map(
                                    (s) => ActionChip(
                                      avatar: const Icon(
                                        Icons.shopping_cart,
                                        size: 16,
                                      ),
                                      label: Text(s.name),
                                      onPressed: s.url == null
                                          ? null
                                          : () => _openUrl(s.url!),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                          const SizedBox(height: 28),
                          const Divider(),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _openUrl('https://rawg.io'),
                            child: Text(
                              'Dados fornecidos por RAWG.io',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            '${rating.toStringAsFixed(1)} / 5',
            style: const TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetacriticBadge extends StatelessWidget {
  final int score;
  const _MetacriticBadge({required this.score});

  @override
  Widget build(BuildContext context) {
    final color = score >= 75
        ? Colors.green
        : (score >= 50 ? Colors.amber : Colors.red);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Metacritic $score',
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
