import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pet_shop/src/lib/config/env_config.dart';

class AuthRemoteRepository {
  final config = EnvConfig();

  final defaultHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

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
