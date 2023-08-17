import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reru/api/all_api.dart';

class DeleteNews_notapprove extends StatefulWidget {
  String uid;
  String news_id;
  
  DeleteNews_notapprove(this.news_id, this.uid);


  @override
  State<DeleteNews_notapprove> createState() => _DeleteNews_notapproveState();
}

class _DeleteNews_notapproveState extends State<DeleteNews_notapprove> {
  String UID = "";

  //fucntion รับ uid ที่ส่งมาจากหน้า Login
  Future getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      UID = preferences.getString('sendUid')!;
      var check = preferences.containsKey('sendUid');
      print("UID = " + UID);
    });
  }

   Future<void> deletenews(String n, String u) async {
    try {
      String uri = "${Api().domain}/delete_news.php";
      var res = await http.post(Uri.parse(uri),
          body: {"news_id": widget.news_id, "uid": UID});
      var jsondata = jsonDecode(res.body);
      print(res);
      if (jsondata["Success"] == 'True') {
        Navigator.pop(context);
        print('Delete success');
      } else {
        print('Delete faild');
      }
    } catch (e) {
      print(e);
    }
  }

  
  @override
  void initState() {
    // TODO: implement initState
    widget.news_id;
    getUid();
    print("reply id = "+widget.news_id);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return AlertDialog(
      title: Center(
        child: Text('คุณต้องการลบข่าวใช่หรือไม่'),
      ),
      content: Row(children: [
        TextButton(
          onPressed: () => deletenews(widget.news_id, UID),
          child: Text("ลบ"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text("ยกเลิก"),
        ),
      ]),
    );
    
  }
}