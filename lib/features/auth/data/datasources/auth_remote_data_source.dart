import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exceptions.dart';
import '../models/app_user_model.dart';

/// Contrato do datasource de autenticação (camada de dados).
abstract class AuthRemoteDataSource {
  Stream<AppUserModel?> authStateChanges();
  Future<AppUserModel> signIn({
    required String email,
    required String password,
  });
  Future<AppUserModel> signUp({
    required String email,
    required String password,
  });
  Future<void> signOut();
}

/// Implementação que usa o Firebase Auth.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Stream<AppUserModel?> authStateChanges() {
    return firebaseAuth.authStateChanges().map(
      (user) => user == null ? null : AppUserModel.fromFirebaseUser(user),
    );
  }

  @override
  Future<AppUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  @override
  Future<AppUserModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapError(e.code));
    }
  }

  @override
  Future<void> signOut() => firebaseAuth.signOut();

  /// Traduz os códigos de erro do Firebase para mensagens em português.
  String _mapError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Email inválido.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email ou password incorretos.';
      case 'email-already-in-use':
        return 'Este email já está registado.';
      case 'weak-password':
        return 'A password é demasiado fraca (mínimo 6 caracteres).';
      default:
        return 'Erro de autenticação. Tenta novamente.';
    }
  }
}
