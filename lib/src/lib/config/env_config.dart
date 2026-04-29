import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  String get({required String key}) {
    return dotenv.get(key);
  }

  String apiBaseUrl() => get(key: "API_BASE_URL");

  Uri getUriFromApiBaseURL({required String path}) {
    final url = '${apiBaseUrl()}/api';
    return Uri.parse(url);
  }
}
