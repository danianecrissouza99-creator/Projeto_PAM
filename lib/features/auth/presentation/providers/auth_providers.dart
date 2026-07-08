import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/sign_out.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';

// ===== Ligação das dependências =====
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.watch(firebaseAuthProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
});

final signInProvider =
    Provider<SignIn>((ref) => SignIn(ref.watch(authRepositoryProvider)));
final signUpProvider =
    Provider<SignUp>((ref) => SignUp(ref.watch(authRepositoryProvider)));
final signOutProvider =
    Provider<SignOut>((ref) => SignOut(ref.watch(authRepositoryProvider)));

// ===== Quem está autenticado (em tempo real) =====
final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

// ===== Controlador das ações: login / registo / logout =====
class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(signInProvider)(
        AuthParams(email: email, password: password),
      );
    });
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(signUpProvider)(
        AuthParams(email: email, password: password),
      );
    });
  }

  Future<void> signOut() async {
    await ref.read(signOutProvider)();
  }
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, void>(AuthController.new);