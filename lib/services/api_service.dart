import 'dart:convert';
import 'dart:io';
import 'package:flutter_hutech_classroom/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<ApiResponse<TResponse>> get<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson,
      {dynamic headers = const {}}) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

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

  Future<ApiResponse<TResponse>> uploadFile<TResponse>(
      String endpoint,
      Map<String, String> fields,
      String fieldName,
      String filePath,
      File file,
      TResponse Function(dynamic json) fromJson,
      {dynamic headers = const {}}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'));

      request.headers.addAll(headers);

      request.fields.addAll(fields);

      var stream = http.ByteStream(file.openRead());

      stream.cast();

      var length = await file.length();

      var multipart =
          http.MultipartFile(fieldName, stream, length, filename: file.path);

      request.files.add(multipart);

      var response = await request.send();
      var body = await response.stream.bytesToString();
      developer.log('Api [UPLOAD FILE POST] $baseUrl$endpoint');

      if (response.statusCode == 200) {
        developer.log('Success [POST]: $body');
        final dynamic jsonResponse = json.decode(body);
        return ApiResponse.success(fromJson(jsonResponse));
      } else {
        final dynamic errorJson = json.decode(body);
        final errors =
            errorJson['errors'] ?? {'errors': 'Unknown error occurred'};
        developer.log('Errors [UPLOAD FILE POST]: $errorJson');
        return ApiResponse.failed(errors);
      }
    } on Exception catch (e) {
      developer.log('Errors [UPLOAD FILE POST]: ${e.toString()}');

      return ApiResponse.failed({'errors': 'Network Error'});
    }
  }

  Future<ApiResponse<TResponse>> post<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson, dynamic body,
      {dynamic headers = const {}}) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl$endpoint'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            ...headers
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

  Future<ApiResponse<TResponse>> put<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson, dynamic body,
      {dynamic headers = const {}}) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl$endpoint'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            ...headers
          });
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

  Future<ApiResponse<TResponse>> patch<TResponse>(
      String endpoint, TResponse Function(dynamic json) fromJson, dynamic body,
      {dynamic headers = const {}}) async {
    try {
      final response = await http.patch(Uri.parse('$baseUrl$endpoint'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            ...headers
          });
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
      String endpoint, TResponse Function(dynamic json) fromJson,
      {dynamic headers = const {}}) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);

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
