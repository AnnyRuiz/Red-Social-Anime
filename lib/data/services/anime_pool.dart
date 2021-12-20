import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:red_max_anime/domain/models/anime_model.dart';
import 'package:red_max_anime/domain/services/misiontic_interface.dart';

class AnimePoolService implements MisionTicService {
  final String baseUrl = 'kitsu.io';
  //final String apiKey = 'wNLombyTzPIjLjkfp/aohu5b0Xy.iOM.4Sj4Q3.s9Ri9riyE6y5E2';

  @override
  Future<List<AnimeModel>> fecthData({int limit = 15, Map? map}) async {
    var queryParameters = {'limit': limit.toString()};
    var uri = Uri.https(baseUrl, '/api/edge/anime', queryParameters);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<AnimeModel> animes = [];
      for (var e in res['data']) {
        animes.add(AnimeModel.fromJson(e));
      }
      return animes;
    } else {
      throw Exception('Error on request');
    }
  }
}
