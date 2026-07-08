import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: iniciar sessão.
class SignIn {
  const SignIn(this._repository);
  final AuthRepository _repository;

  Future<AppUser> call(AuthParams params) {
    return _repository.signIn(email: params.email, password: params.password);
  }
}

/// Parâmetros partilhados por sign in / sign up.
class AuthParams {
  final String email;
  final String password;
  const AuthParams({required this.email, required this.password});
}