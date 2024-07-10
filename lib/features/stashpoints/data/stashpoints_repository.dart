import 'package:stashpoints/common/configs/env_config.dart';
import 'package:stashpoints/common/exceptions/resource_not_found_exception.dart';
import 'package:stashpoints/common/interfaces/http_client.dart';
import 'package:stashpoints/features/stashpoints/domain/stashpoint.dart';

class StashpointsRepository {
  StashpointsRepository({
    required HttpClient client,
  }) : _client = client;

  final HttpClient _client;

  Future<List<Stashpoint>> fetchStashpoints({
    required int page,
  }) async {
    try {
      final response = await _client.get(
        '${EnvConfig.restEndpoint}/stashpoints',
        queryParams: {
          'page': page.toString(),
        },
      );

      final List<dynamic>? items = response['items'];

      if (items == null) return [];

      final List<Stashpoint> stashpoints =
          items.map((e) => Stashpoint.fromJson(e)).toList();

      return stashpoints;
    } on ResourceNotFoundException {
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
