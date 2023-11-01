import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_key.dart';
import '../error/fetch_image_exception.dart';

class ImageRepository {
  ImageRepository._internal();
  static final ImageRepository _instance = ImageRepository._internal();
  factory ImageRepository() => _instance;

  Future<String> fetchImageUrl(String prompt) async {
    // To test error handling
    // return Future.delayed(Duration(seconds: 1), () => Future.error('Error'));

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $kApiKey',
        },
        body: jsonEncode(
          {
            'prompt': prompt,
            'n': 1,
            'size': '256x256',
          },
        ),
      );
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['error'] != null) {
        throw FetchImageException(body['error']['message']);
      }
      if (body['data'] == null) {
        throw const FetchImageException('Couldn\'t receive the image.');
      }
      return body['data'][0]['url'] as String;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
