import '../../domain/entities/favorite_game.dart';

/// Versão "de dados" do FavoriteGame: sabe converter-se de/para o Firestore.
class FavoriteGameModel extends FavoriteGame {
  const FavoriteGameModel({
    required super.id,
    required super.name,
    super.backgroundImage,
    required super.rating,
  });

  /// A partir da entity (quando o utilizador clica em favoritar).
  factory FavoriteGameModel.fromEntity(FavoriteGame game) {
    return FavoriteGameModel(
      id: game.id,
      name: game.name,
      backgroundImage: game.backgroundImage,
      rating: game.rating,
    );
  }

  /// A partir de um documento do Firestore.
  factory FavoriteGameModel.fromMap(Map<String, dynamic> map) {
    return FavoriteGameModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? 'Sem nome',
      backgroundImage: map['backgroundImage'] as String?,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Para gravar no Firestore.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'backgroundImage': backgroundImage,
      'rating': rating,
    };
  }
}
