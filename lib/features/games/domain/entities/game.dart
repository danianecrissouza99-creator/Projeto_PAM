import 'package:equatable/equatable.dart';

/// Representa um jogo na nossa app (objeto de negócio).
/// Camada de DOMÍNIO: Dart puro, sem Flutter, sem Firebase, sem API.
class Game extends Equatable {
  final int id;
  final String name;
  final String? backgroundImage;
  final double rating;
  final String? released;
  final List<String> genres;

  const Game({
    required this.id,
    required this.name,
    this.backgroundImage,
    required this.rating,
    this.released,
    this.genres = const [],
  });

  @override
  List<Object?> get props =>
      [id, name, backgroundImage, rating, released, genres];
}