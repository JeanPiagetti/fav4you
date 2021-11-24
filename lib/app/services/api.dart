import 'dart:convert';

import 'package:fav4you/app/models/video.dart';
import 'package:fav4you/app/shared/utils/constants.dart';
import 'package:http/http.dart' as http;


class Api {
  String? _search;
  String? _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;

    http.Response resp = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=&type=video&key=$API_KEY&maxResults=10"));
    
    return decode(resp);
  }

  Future<List<Video>> nextPage() async {
    http.Response resp = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"));
    print(resp.body);
    return decode(resp);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      _nextToken = decoded['nextPageToken'];
      List<Video> videos =
          decoded['items'].map<Video>((item) => Video.fromJson(item)).toList();

      return videos;
    }

    throw new Exception('${json.decode(response.body)['error']['message']}');
  }
}
