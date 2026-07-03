import 'package:equatable/equatable.dart';

/// Uma loja onde o jogo está disponível (ex.: Steam, PlayStation Store).
class GameStore extends Equatable {
  final String name;
  final String? url;
  const GameStore({required this.name, this.url});

  @override
  List<Object?> get props => [name, url];
}

/// Representa um jogo na nossa app (objeto de negócio).
class Game extends Equatable {
  final int id;
  final String name;
  final String? backgroundImage;
  final double rating;
  final String? released;
  final List<String> genres;
  final String? description;
  final int? metacritic;
  final List<String> platforms;
  final List<GameStore> stores;

  const Game({
    required this.id,
    required this.name,
    this.backgroundImage,
    required this.rating,
    this.released,
    this.genres = const [],
    this.description,
    this.metacritic,
    this.platforms = const [],
    this.stores = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        backgroundImage,
        rating,
        released,
        genres,
        description,
        metacritic,
        platforms,
        stores,
      ];
}