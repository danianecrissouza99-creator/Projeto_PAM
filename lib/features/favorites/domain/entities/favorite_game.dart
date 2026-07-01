import 'package:equatable/equatable.dart';

/// Um jogo guardado nos favoritos (camada de domínio).
/// Guardamos só o essencial para mostrar na lista de favoritos,
/// sem precisar de voltar a chamar a RAWG.
class FavoriteGame extends Equatable {
  final int id;
  final String name;
  final String? backgroundImage;
  final double rating;

  const FavoriteGame({
    required this.id,
    required this.name,
    this.backgroundImage,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, name, backgroundImage, rating];
}
