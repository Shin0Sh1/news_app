class NewsFetchException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  NewsFetchException({required this.message, this.statusCode, this.details});

  @override
  String toString() =>
      'NewsFetchException: $message (statusCode: $statusCode, details: $details)';
}
