import 'package:flutter/material.dart';
import '../../domain/entities/game.dart';

/// Cartão reutilizável que mostra um jogo (imagem, nome, rating, data).
class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback? onTap;

  const GameCard({super.key, required this.game, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (game.backgroundImage != null)
              Image.network(
                game.backgroundImage!,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : const SizedBox(
                        height: 160,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                errorBuilder: (context, error, stack) => const SizedBox(
                  height: 160,
                  child: Icon(Icons.videogame_asset, size: 48),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(game.rating.toStringAsFixed(1)),
                      const SizedBox(width: 12),
                      if (game.released != null)
                        Text(
                          game.released!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
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