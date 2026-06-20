import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const urlString = 'https://jsonplaceholder.typicode.com/posts';

const requestTimeoutSeconds = 10;

Future<String> sendTime(int time) async {
  final url = Uri.parse(urlString);

  try {
    final response = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'pace_seconds': time.toString()}),
        )
        .timeout(const Duration(seconds: requestTimeoutSeconds));

    if (response.statusCode >= HttpStatus.ok ||
        response.statusCode <= HttpStatus.alreadyReported) {
      return jsonDecode(response.body)['pace_seconds'];
    } else {
      return Future.error('Http error: ${response.statusCode}');
    }
  } catch (e) {
    return Future.error(e.toString());
  }
}
