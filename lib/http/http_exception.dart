import 'package:http/http.dart';

class HttpException implements Exception {
  final Response _response;

  const HttpException(this._response);

  Map<String, String> get headers => _response.headers;

  int get statusCode => _response.statusCode;

  String get body => _response.body;
}
