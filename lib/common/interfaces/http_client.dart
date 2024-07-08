abstract class HttpClient {
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParams,
  });

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? body,
  });
}
