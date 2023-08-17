import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reru/api/all_api.dart';

class Deletereply extends StatefulWidget {
  String uid;
  String reply_id;
  String news_id;

  Deletereply(this.news_id,this.reply_id, this.uid);

  @override
  State<Deletereply> createState() => _DeletereplyState();
}

class _DeletereplyState extends State<Deletereply> {
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

  Future<void> deletereply(String r, String u) async {
    try {
      String uri = "${Api().domain}/delete_reply.php";
      var res = await http.post(Uri.parse(uri),
          body: {
            "news_id": widget.news_id,
            "reply_id": widget.reply_id, "uid": UID});
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
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.reply_id;
    widget.news_id;
    getUid();
    print("reply id = " + widget.news_id);
    print("reply id = " + widget.reply_id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('คุณต้องการลบความคิดเห็นใช่หรือไม่'),
      ),
      content: Row(children: [
        TextButton(
          onPressed: () => deletereply(widget.reply_id, UID),
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
