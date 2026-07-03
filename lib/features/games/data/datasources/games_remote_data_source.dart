import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/game_model.dart';

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

class GamesRemoteDataSourceImpl implements GamesRemoteDataSource {
  final Dio dio;
  GamesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<GameModel>> getGames({
    String? search,
    String? ordering,
    String? genres,
    int page = 1,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.games,
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          if (ordering != null) 'ordering': ordering,
          if (genres != null) 'genres': genres,
          'page': page,
          'page_size': 40,
        },
      );
      final results = response.data['results'] as List<dynamic>;
      return results
          .map((json) => GameModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<GameModel> getGameDetails(int id) async {
    try {
      final response = await dio.get('${ApiConstants.games}/$id');
      return GameModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getScreenshots(int id) async {
    try {
      final response = await dio.get('${ApiConstants.games}/$id/screenshots');
      final results = response.data['results'] as List<dynamic>;
      return results.map((s) => s['image'] as String).toList();
    } on DioException {
      throw ServerException();
    }
  }
}
