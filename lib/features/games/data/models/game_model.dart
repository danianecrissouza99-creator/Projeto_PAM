import '../../domain/entities/game.dart';

/// Versão "de dados" do Game: constrói-se a partir do JSON da RAWG.
class GameModel extends Game {
  const GameModel({
    required super.id,
    required super.name,
    super.backgroundImage,
    required super.rating,
    super.released,
    super.genres,
    super.description,
    super.metacritic,
    super.platforms,
    super.stores,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Sem nome',
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      released: json['released'] as String?,
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((g) => g['name'] as String)
              .toList() ??
          const [],
      description: json['description_raw'] as String?,
      metacritic: json['metacritic'] as int?,
      platforms:
          (json['platforms'] as List<dynamic>?)
              ?.map((p) => (p['platform']?['name'] ?? '') as String)
              .where((name) => name.isNotEmpty)
              .toList() ??
          const [],
      stores:
          (json['stores'] as List<dynamic>?)?.map((s) {
            final store = s['store'] as Map<String, dynamic>?;
            final domain = store?['domain'] as String?;
            return GameStore(
              name: (store?['name'] ?? 'Loja') as String,
              url: domain != null ? 'https://$domain' : null,
            );
          }).toList() ??
          const [],
    );
  }
}
