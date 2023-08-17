import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../api/all_api.dart';

class Editreply extends StatefulWidget {
  String uid;
  String reply_id;
  String text;
  Editreply(this.text, this.reply_id, this.uid);

  @override
  State<Editreply> createState() => _EditreplyState();
}

class _EditreplyState extends State<Editreply> {
  TextEditingController replyController = TextEditingController();

  String UID = "";

  //fucntion รับ uid ที่ส่งมาจากหน้า Login
  Future getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      UID = preferences.getString('sendUid')!;
      var check = preferences.containsKey('sendUid');

      print(check);
      print(UID);
    });
  }

  Future<void> updateReply() async {
    try {
      String uri = "${Api().domain}/editreply.php";
      var res = await http.post(Uri.parse(uri), body: {
        "text": replyController.text,
        "reply_id": widget.reply_id,
        "uid": UID
      });
      var jsondata = jsonDecode(res.body);
      print(res);
      if (jsondata["Success"] == 'True') {
        Navigator.pop(context);
        print('update success');
        setState(() {
          widget.text;
        });
      } else {
        print('update faild');
      }
    } catch (e) {
      print(e);
    }
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    replyController.text = widget.text;
    widget.reply_id;
    getUid();

    super.initState();
  }

  void clearText() {
    replyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: TextField(
            controller: replyController, decoration: const InputDecoration()),
        content: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    updateReply();
                  },
                  child: Text('แก้ไข'),
                ),
                TextButton(
                  onPressed: () => clearText(),
                  child: Text("ลบ"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text('ยกเลิก'),
                ),
              ],
            )
          ],
        ));
  }
}
