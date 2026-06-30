import 'package:equatable/equatable.dart';

/// Falhas apresentadas ao utilizador (camada de domínio).
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Ocorreu um erro no servidor.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sem ligação à internet.']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Falha na autenticação.']);
}