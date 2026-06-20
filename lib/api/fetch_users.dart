import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:swim_swim/model/user_model.dart';

const requestTimeoutSeconds = 10;
const urlString = 'https://jsonplaceholder.typicode.com/users';

Future<List<User>> featchUsers() async {
  final url = Uri.parse(urlString);

  try {
    final response = await http
        .get(url, headers: {'Content-Type': 'application/json'})
        .timeout(const Duration(seconds: requestTimeoutSeconds));

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      return Future.error('Http error: ${response.statusCode}');
    }
  } catch (e) {
    return Future.error(e.toString());
  }
}
