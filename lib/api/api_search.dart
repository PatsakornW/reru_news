import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reru/api/all_api.dart';
import 'package:reru/model/NewsModel.dart';

class FetchNews {
  var data = [];
  List<NewsModel> result = [];
  String fetchurl = "${Api().domain}/getdata_app.php";
  Future<List<NewsModel>> getNewsList(String? query) async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        result = data.map((e) => NewsModel.fromJson(e)).toList();
        if (query != null) {
          result = result
              .where((element) =>
                  element.newsTitle!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('API ERROR 404 ');
      }
    } on Exception catch (e) {
      print('error :$e');
    }
    return result;
  }
}
