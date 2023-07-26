import 'dart:convert';


import 'package:http/http.dart';


import '../../modelclass/AimeModel.dart';
import '../api_client.dart';


class AnimeApi {
  ApiClient apiClient = ApiClient();


  Future<AimeModel> getAnime() async {
    String trendingpath = 'https://anime-db.p.rapidapi.com/anime?page=1&size=10&search=Fullmetal&genres=Fantasy,Drama&sortBy=ranking&sortOrder=asc';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return AimeModel.fromJson(jsonDecode(response.body));
  }
}