import 'dart:convert';
import 'dart:io';

import 'package:fav4you/app/models/video.dart';
import 'package:fav4you/app/shared/utils/constants.dart';
import 'package:http/http.dart' as http;


class Api {
    
    final String _baseUrl = 'www.googleapis.com';
    String _nextPageToken = '';

    Api._instantiate();
    static final Api instance = Api._instantiate();

  Future<List<Video>> fetchVideos() async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'maxResults': '10',
      'chart':'mostPopular',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/videos',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      
      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach((json) => videos.add(
          Video.fromJson(json)));
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> findOne(String videoId) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'maxResults': '10',
      'search': videoId,
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromJson(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
  
  Future<List<Video>> findAll() async {
    http.Response resp = await http.get(Uri.parse(
        '$BASE_URL/search?part=snippet&q=&type=video&key=$API_KEY&maxResults=10'));
        
    if(resp.statusCode == 200){
      Iterable list = json.decode(resp.body)['items'];
      List<Video> videos = list.map((e) => Video.fromJson(e)).toList();
      return videos;
    } else {
      throw Exception('Erro na requisição');
    }
    
  }

}
