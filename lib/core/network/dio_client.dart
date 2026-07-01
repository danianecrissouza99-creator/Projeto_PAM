import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../constants/api_keys.dart';

/// Fornece uma instância única e configurada do Dio para falar com a RAWG.
/// A chave da API é adicionada automaticamente a TODOS os pedidos.
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      queryParameters: {'key': kRawgApiKey},
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
});