import '../../../../core/usecases/usecase.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: iniciar sessão.
class SignIn implements UseCase<AppUser, AuthParams> {
  final AuthRepository repository;
  SignIn(this.repository);

  @override
  Future<AppUser> call(AuthParams params) {
    return repository.signIn(email: params.email, password: params.password);
  }
}

/// Parâmetros partilhados por sign in / sign up.
class AuthParams {
  final String email;
  final String password;
  const AuthParams({required this.email, required this.password});
}
