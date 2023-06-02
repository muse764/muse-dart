import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart' as http;
import 'model/constants.dart';
import 'model/user/user.dart';

class Muse {
  Muse({this.debug = true});

  final bool debug;

  Future<Map<String, dynamic>> _getResponse(String url) async {
    http.Response response;
    if (debug) print(baseUrl + url);
    do {
      response = await http.get(Uri.parse(baseUrl + url));
    } while (response.statusCode == 429 || response.statusCode == 500);

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> _postResponse(
      String url, Map<String, dynamic> body) async {
    http.Response response;
    if (debug) print(baseUrl + url);
    do {
      response = await http.post(Uri.parse(baseUrl + url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(body));
    } while (response.statusCode == 429 || response.statusCode == 500);

    return json.decode(response.body);
  }

  Future<BuiltList<User>> getUsers() async {
    var url = '/users';
    var response = await _getResponse(url);
    final responseList = response['users'] ?? [];
    return BuiltList<User>(responseList.map((user) => User.fromJson(user)));
  }

  Future<User> getUser(String id) async {
    var url = '/users/$id';
    var response = await _getResponse(url);
    return User.fromJson(response);
  }

  Future createUser(String email, String username, String password) async {
    var url = '/auth/register';
    var body = {
      'email': email,
      'username': username,
      'password': password,
    };
    var response = await _postResponse(url, body);
    return response;
  }
}
