import 'package:equatable/equatable.dart';

/// Representa um utilizador autenticado (camada de domínio).
/// Dart puro — não sabe nada do Firebase.
class AppUser extends Equatable {
  final String uid;
  final String email;

  const AppUser({required this.uid, required this.email});

  @override
  List<Object?> get props => [uid, email];
}
