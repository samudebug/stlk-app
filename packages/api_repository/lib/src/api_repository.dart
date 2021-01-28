import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class APIError implements Exception {
  const APIError(this.errorCode);
  final int errorCode;
}

class APIRepository {
  const APIRepository();
  Future<dynamic> performGet(String url, {Map headers}) async {
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      print(response.statusCode);
      print(response.body);
      throw APIError(response.statusCode);
    }
    return jsonDecode(response.body);
  }
}
