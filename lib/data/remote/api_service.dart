import 'dart:io';

import 'package:country_info_app/data/remote/api_strings.dart';
import 'package:http/http.dart' as http;

class APIService {
  final http.Client _client;
  static const _timeoutSeconds = 10;

  APIService(this._client);

  factory APIService.defaultClient() => APIService(http.Client());

  static const String _baseUrl = APIStrings.authority;

  Future<String> get({
    required String unencodedPath
  }) async {
    http.Response response = await _client
        .get(Uri.https(_baseUrl, unencodedPath))
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw HttpException('${response.statusCode} http error');
    }
  }
}
