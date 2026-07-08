import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';
import 'sign_in.dart'; // reutiliza o AuthParams

/// Caso de uso: registar uma nova conta.
class SignUp {
  const SignUp(this._repository);
  final AuthRepository _repository;

  Future<AppUser> call(AuthParams params) {
    return _repository.signUp(email: params.email, password: params.password);
  }
}