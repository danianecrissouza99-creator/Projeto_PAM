import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/app_user.dart';

/// Versão "de dados" do AppUser: sabe construir-se a partir de um User do Firebase.
class AppUserModel extends AppUser {
  const AppUserModel({required super.uid, required super.email});

  factory AppUserModel.fromFirebaseUser(User user) {
    return AppUserModel(uid: user.uid, email: user.email ?? '');
  }
}
