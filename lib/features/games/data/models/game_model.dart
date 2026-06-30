import '../../domain/entities/game.dart';

/// Versão "de dados" do Game: sabe construir-se a partir do JSON da RAWG.
/// Herda de Game (a entity) e só acrescenta a tradução do JSON.
class GameModel extends Game {
  const GameModel({
    required super.id,
    required super.name,
    super.backgroundImage,
    required super.rating,
    super.released,
    super.genres,
  });

  /// Converte o JSON de um jogo (da RAWG) num GameModel.
  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Sem nome',
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      released: json['released'] as String?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((g) => g['name'] as String)
              .toList() ??
          const [],
    );
  }
}