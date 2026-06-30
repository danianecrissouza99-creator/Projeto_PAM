/// Exceções lançadas pela camada de dados (data sources).
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Erro no servidor. Tenta novamente.']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Sem ligação à internet.']);
}

class AuthException implements Exception {
  final String message;
  AuthException([this.message = 'Erro de autenticação.']);
}