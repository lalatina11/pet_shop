import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pet_shop/src/lib/api_response.dart';
import 'package:pet_shop/src/lib/config/env_config.dart';

class AuthRemoteRepository {
  final config = EnvConfig();

  final defaultHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<ApiResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        config.getUriFromApiBaseURL(path: "/auth/register"),
        body: jsonEncode({"name": name, "email": email, "password": password}),
        headers: {...defaultHeaders},
      );
      final result = jsonDecode(res.body);
      if (!result['success']) {
        return ApiResponse(
          success: false,
          message: result['message'],
          data: null,
        );
      }
      return ApiResponse(
        success: true,
        message: result['message'],
        data: result['data']['token'],
      );
    } catch (err) {
      print("remote error ${err.toString()}");
      return ApiResponse(
        success: false,
        message: "Unexpexted error",
        data: null,
      );
    }
  }

  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        config.getUriFromApiBaseURL(path: "/auth/login"),
        body: jsonEncode({"email": email, "password": password}),
        headers: {...defaultHeaders},
      );
      final result = jsonDecode(res.body);
      if (!result['success']) {
        return ApiResponse(
          success: false,
          message: result['message'],
          data: null,
        );
      }
      return ApiResponse(
        success: true,
        message: result['message'],
        data: result['data']['token'],
      );
    } catch (err) {
      print("remote error ${err.toString()}");
      return ApiResponse(
        success: false,
        message: "Unexpexted error",
        data: null,
      );
    }
  }

  Future<ApiResponse> logout({required String token}) async {
    try {
      final res = await http.post(
        config.getUriFromApiBaseURL(path: "/auth/logout"),
        headers: {...defaultHeaders, "Authorization": "Bearer $token"},
      );
      final result = jsonDecode(res.body);
      if (!result['success']) {
        return ApiResponse(
          success: false,
          message: result['message'],
          data: null,
        );
      }
      return ApiResponse(success: true, message: result['message'], data: null);
    } catch (err) {
      print("remote error ${err.toString()}");
      return ApiResponse(
        success: false,
        message: "Unexpexted error",
        data: null,
      );
    }
  }

  Future<bool> checkIsLoggedIn({required String token}) async {
    try {
      final res = await http.get(
        config.getUriFromApiBaseURL(path: "/auth/current-user"),
        headers: {...defaultHeaders, "Authorization": "Bearer $token"},
      );
      final result = jsonDecode(res.body);
      return result['success'] == true;
    } catch (e) {
      return false;
    }
  }
}
