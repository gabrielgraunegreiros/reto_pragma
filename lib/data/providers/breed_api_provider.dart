import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reto_pragma/domain/models/breed.dart';
import 'package:reto_pragma/domain/models/breed_detail.dart';

class BreedApiProvider {
  final _host = 'api.thecatapi.com';
  final _basePath = '/v1';
  final apiKey = dotenv.env['API_KEY'];

  Future<List<Breed>> fetchBreeds({int limit = 10, int page = 0}) async {
    final uri = Uri.https(
      _host,
      '$_basePath/breeds',
      {
        'limit': limit.toString(),
        'page': page.toString()
      },
    );
    final response = await http.get(
      uri,
      headers: {
        'x-api-key': apiKey ?? ''
      }
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => Breed.fromJson(item)).toList();
    } else {
      throw 'Unable to load data. Please check your connection and try again.';
    }
  }

  Future<BreedDetail> fetchBreedById(String breedId) async {
    final uri = Uri.https(_host,'$_basePath/breeds/$breedId');
    final response = await http.get(
      uri,
      headers: {
        'x-api-key': apiKey ?? ''
      }
    );

    if (response.statusCode == 200) {
      return BreedDetail.fromJson(jsonDecode(response.body));
    } else {
      throw 'Unable to load breed detail data. Please check your connection and try again.';
    }
  }

  Future<List<Breed>> searchBreeds(String query) async {
    final uri = Uri.https(
      _host,
      '$_basePath/breeds/search',
      {
        'q': query,
        'attach_image': '1'
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'x-api-key': apiKey ?? ''
      }
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => Breed.fromJson(item)).toList();
    } else {
      throw 'Unable to search breeds. Please check your connection and try again';
    }
  }
}