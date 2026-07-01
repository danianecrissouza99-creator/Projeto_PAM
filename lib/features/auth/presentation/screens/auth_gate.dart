import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../games/presentation/screens/games_list_screen.dart';
import '../providers/auth_providers.dart';
import 'login_screen.dart';

/// Decide o que mostrar consoante o estado de autenticação:
/// - se há utilizador  -> a app (lista de jogos)
/// - se não há          -> o ecrã de login
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Erro: $error'))),
      data: (user) =>
          user == null ? const LoginScreen() : const GamesListScreen(),
    );
  }
}
