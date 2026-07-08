import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/api_keys.dart';
import '../../../../core/error/exceptions.dart';
import '../models/game_model.dart';

/// Contrato do datasource (camada de dados): vai buscar jogos à RAWG.
abstract class GamesRemoteDataSource {
  Future<List<GameModel>> getGames({
    String? search,
    String? ordering,
    String? genres,
    int page = 1,
  });
  Future<GameModel> getGameDetails(int id);
  Future<List<String>> getScreenshots(int id);
}

/// Implementação que usa o package http para falar com a API RAWG.
class GamesRemoteDataSourceImpl implements GamesRemoteDataSource {
  GamesRemoteDataSourceImpl({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<GameModel>> getGames({
    String? search,
    String? ordering,
    String? genres,
    int page = 1,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.games}')
        .replace(queryParameters: {
      'key': kRawgApiKey,
      if (search != null && search.isNotEmpty) 'search': search,
      if (ordering != null) 'ordering': ordering,
      if (genres != null) 'genres': genres,
      'page': '$page',
      'page_size': '40',
    });

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;
    return results
        .map((json) => GameModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<GameModel> getGameDetails(int id) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.games}/$id')
        .replace(queryParameters: {'key': kRawgApiKey});

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return GameModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  @override
  Future<List<String>> getScreenshots(int id) async {
    final uri = Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.games}/$id/screenshots')
        .replace(queryParameters: {'key': kRawgApiKey});

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;
    return results.map((s) => s['image'] as String).toList();
  }
}