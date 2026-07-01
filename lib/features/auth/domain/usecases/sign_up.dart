import '../../../../core/usecases/usecase.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';
import 'sign_in.dart'; // reutiliza o AuthParams

/// Caso de uso: registar uma nova conta.
class SignUp implements UseCase<AppUser, AuthParams> {
  final AuthRepository repository;
  SignUp(this.repository);

  @override
  Future<AppUser> call(AuthParams params) {
    return repository.signUp(email: params.email, password: params.password);
  }
}
