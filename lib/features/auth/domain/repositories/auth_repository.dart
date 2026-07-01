import '../entities/app_user.dart';

/// Contrato de autenticação (camada de domínio).
/// Define O QUE se pode fazer; o "como" (Firebase) fica na camada de dados.
abstract class AuthRepository {
  /// Utilizador atual em tempo real (null = ninguém autenticado).
  Stream<AppUser?> authStateChanges();

  /// Inicia sessão com email e password.
  Future<AppUser> signIn({required String email, required String password});

  /// Cria uma nova conta com email e password.
  Future<AppUser> signUp({required String email, required String password});

  /// Termina a sessão.
  Future<void> signOut();
}
