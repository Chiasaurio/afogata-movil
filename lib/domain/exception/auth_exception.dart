class AuthException implements Exception {
  final bool ok;
  final String message;

  AuthException({required this.ok, required this.message});
}
