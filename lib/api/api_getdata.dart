import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reru/api/all_api.dart';
import 'package:reru/model/NewsModel.dart';

class getNews {
  var data = [];
  List<NewsModel> result = [];
  String fetchurl = "${Api().domain}/getdata_app.php";
  Future<List<NewsModel>> getNewsList() async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        result = data.map((e) => NewsModel.fromJson(e)).toList();
    
      } else {
        print('API ERROR 404 ');
      }
    } on Exception catch (e) {
      print('error :$e');
    }
    return result;
  }
}


class getNewsHot {
  var data = [];
  List<NewsModel> result = [];
  String fetchurl = "${Api().domain}/getData_Hot.php";
  Future<List<NewsModel>> getNewsList() async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        result = data.map((e) => NewsModel.fromJson(e)).toList();
    
      } else {
        print('API ERROR 404 ');
      }
    } on Exception catch (e) {
      print('error :$e');
    }
    return result;
  }
}

class getNewsNews {
  var data = [];
  List<NewsModel> result = [];
  String fetchurl = "${Api().domain}/getDataNews.php";
  Future<List<NewsModel>> getNewsList() async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        result = data.map((e) => NewsModel.fromJson(e)).toList();
    
      } else {
        print('API ERROR 404 ');
      }
    } on Exception catch (e) {
      print('error :$e');
    }
    return result;
  }
}
