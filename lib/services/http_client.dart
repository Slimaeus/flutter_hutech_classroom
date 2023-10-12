import 'dart:convert';
import 'package:flutter_hutech_classroom/models/api_response.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;

  HttpClient(this.baseUrl);

  Future<ApiResponse<TResponse>> get<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors = errorJson['errors'] ?? ['Unknown error occurred'];
        return ApiResponse.failed(errors);
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      return ApiResponse.failed({'error': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> post<TResponse>(String endpoint,
      TResponse Function(dynamic json) fromJson, dynamic body) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl$endpoint'), body: body);

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors = errorJson['errors'] ?? ['Unknown error occurred'];
        return ApiResponse.failed(errors);
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      return ApiResponse.failed({'error': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> put<TResponse>(String endpoint,
      TResponse Function(dynamic json) fromJson, dynamic body) async {
    try {
      final response =
          await http.put(Uri.parse('$baseUrl$endpoint'), body: body);

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors = errorJson['errors'] ?? ['Unknown error occurred'];
        return ApiResponse.failed(errors);
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      return ApiResponse.failed({'error': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> patch<TResponse>(String endpoint,
      TResponse Function(dynamic json) fromJson, dynamic body) async {
    try {
      final response =
          await http.patch(Uri.parse('$baseUrl$endpoint'), body: body);

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors = errorJson['errors'] ?? ['Unknown error occurred'];
        return ApiResponse.failed(errors);
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      return ApiResponse.failed({'error': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> delete<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'));

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors = errorJson['errors'] ?? ['Unknown error occurred'];
        return ApiResponse.failed(errors);
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      return ApiResponse.failed({'error': 'Network Error'});
    }
  }
}
