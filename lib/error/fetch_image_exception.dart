class FetchImageException implements Exception {
  const FetchImageException(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }
}
