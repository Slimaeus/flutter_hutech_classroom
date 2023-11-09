import 'dart:convert';
import 'package:flutter_hutech_classroom/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<ApiResponse<TResponse>> get<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      developer.log('Api [GET] $baseUrl$endpoint');
      if (response.statusCode == 200) {
        developer.log('Success [GET]: ${response.body}');
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors =
            errorJson['errors'] ?? {'errors': 'Unknown error occurred'};
        developer.log('Errors [GET]: $errorJson');
        return ApiResponse.failed(errors);
      }
    } on Exception catch (e) {
      developer.log('Errors [GET]: ${e.toString()}');

      return ApiResponse.failed({'errors': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> post<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson, dynamic body,
      {dynamic header}) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl$endpoint'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      developer.log('Api [POST] $baseUrl$endpoint');

      if (response.statusCode == 200) {
        developer.log('Success [POST]: ${response.body}');
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors =
            errorJson['errors'] ?? {'errors': 'Unknown error occurred'};
        developer.log('Errors [POST]: $errorJson');
        return ApiResponse.failed(errors);
      }
    } on Exception catch (e) {
      developer.log('Errors [POST]: ${e.toString()}');

      return ApiResponse.failed({'errors': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> put<TResponse>(String endpoint,
      TResponse Function(dynamic json) fromJson, dynamic body) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl$endpoint'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      developer.log('Api [PUT] $baseUrl$endpoint');

      if (response.statusCode == 200) {
        developer.log('Success [PUT]: ${response.body}');
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors =
            errorJson['errors'] ?? {'errors': 'Unknown error occurred'};
        developer.log('Errors [PUT]: $errorJson');
        return ApiResponse.failed(errors);
      }
    } on Exception catch (e) {
      developer.log('Errors [PUT]: ${e.toString()}');

      return ApiResponse.failed({'errors': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> patch<TResponse>(String endpoint,
      TResponse Function(dynamic json) fromJson, dynamic body) async {
    try {
      final response = await http.patch(Uri.parse('$baseUrl$endpoint'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      developer.log('Api [PATCH] $baseUrl$endpoint');

      if (response.statusCode == 200) {
        developer.log('Success [PATCH]: ${response.body}');
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors =
            errorJson['errors'] ?? {'errors': 'Unknown error occurred'};
        developer.log('Errors [PATCH]: $errorJson');
        return ApiResponse.failed(errors);
      }
    } on Exception catch (e) {
      developer.log('Errors [PATCH]: ${e.toString()}');

      return ApiResponse.failed({'errors': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> delete<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'));

      developer.log('Api [DELETE] $baseUrl$endpoint');
      if (response.statusCode == 200) {
        developer.log('Success [DELETE]: ${response.body}');
        final dynamic jsonResponse = json.decode(response.body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(response.body);
        final errors =
            errorJson['errors'] ?? {'errors': 'Unknown error occurred'};
        developer.log('Errors [DELETE]: $errorJson');
        return ApiResponse.failed(errors);
      }
    } on Exception catch (e) {
      developer.log('Errors [DELETE]: ${e.toString()}');

      return ApiResponse.failed({'errors': 'Network Error'});
    }
  }
}
