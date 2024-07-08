import 'dart:convert';
import 'dart:io';

import 'package:stashpoints/common/interfaces/http_client.dart';
import 'package:http/http.dart' as http;

class HttpService implements HttpClient {
  @override
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw HttpException('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Failed to load data: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw HttpException('Failed to create data: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Failed to create data: $e');
    }
  }
}
