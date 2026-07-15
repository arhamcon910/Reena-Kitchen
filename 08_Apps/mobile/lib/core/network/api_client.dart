import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';

class ApiClient {
  ApiClient({String? baseUrl}) : _baseUrl = baseUrl ?? AppConstants.apiBaseUrl;
  final String _baseUrl;

  Map<String, String> _headers({String? token}) => {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  Uri _uri(String path) => Uri.parse('$_baseUrl$path');

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body,
      {String? token}) async {
    final res = await http.post(_uri(path),
        headers: _headers(token: token), body: jsonEncode(body));
    final decoded = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode >= 400) {
      throw ApiException(statusCode: res.statusCode,
          message: decoded['message']?.toString() ?? 'Error');
    }
    return decoded;
  }

  Future<dynamic> get(String path, {String? token}) async {
    final res = await http.get(_uri(path), headers: _headers(token: token));
    final decoded = jsonDecode(res.body);
    if (res.statusCode >= 400) {
      final map = decoded as Map<String, dynamic>;
      throw ApiException(statusCode: res.statusCode,
          message: map['message']?.toString() ?? 'Error');
    }
    return decoded;
  }

  Future<Map<String, dynamic>> patch(String path, Map<String, dynamic> body,
      {String? token}) async {
    final res = await http.patch(_uri(path),
        headers: _headers(token: token), body: jsonEncode(body));
    final decoded = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode >= 400) {
      throw ApiException(statusCode: res.statusCode,
          message: decoded['message']?.toString() ?? 'Error');
    }
    return decoded;
  }

  Future<void> delete(String path, {String? token}) async {
    final res = await http.delete(_uri(path), headers: _headers(token: token));
    if (res.statusCode >= 400) {
      final decoded = jsonDecode(res.body) as Map<String, dynamic>;
      throw ApiException(statusCode: res.statusCode,
          message: decoded['message']?.toString() ?? 'Error');
    }
  }
}

class ApiException implements Exception {
  const ApiException({required this.statusCode, required this.message});
  final int statusCode;
  final String message;
  @override
  String toString() => 'ApiException($statusCode): $message';
}
