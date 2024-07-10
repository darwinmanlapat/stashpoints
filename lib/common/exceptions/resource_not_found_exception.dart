class ResourceNotFoundException implements Exception {
  final String message;

  ResourceNotFoundException([this.message = "Resource not found"]);

  @override
  String toString() => "ResourceNotFoundException: $message";
}
