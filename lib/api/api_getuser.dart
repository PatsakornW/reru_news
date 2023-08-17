import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reru/model/NewsModel.dart';

class getUser {
  String UID = "";
  var data = [];
  List<NewsModel> result = [];
  String fetchurl = "http://192.168.1.6/reru/getdata_app.php";
  Future<List<NewsModel>> getNewsList() async {
    var url = Uri.parse(fetchurl);
    var response = await http.post(url,body: {
      "uid":UID
    });
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
