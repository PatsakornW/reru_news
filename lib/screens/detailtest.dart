// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import, unnecessary_new, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reru/screens/allnews.dart';
import 'dart:convert';

import 'package:reru/screens/details.dart';
import 'package:reru/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsTest extends StatefulWidget {
  List list;
  int index;
  DetailsTest({required this.index, required this.list});

  @override
  State<DetailsTest> createState() => _DetailsTestState();
}

class _DetailsTestState extends State<DetailsTest> {
  TextEditingController replyController = TextEditingController();
  final _controller = TextEditingController();

  //clear text
  void clearText() {
    replyController.clear();
  }

  //String isLikeOrDislike = "";
  String UID = "";

  //fucntion รับ uid ที่ส่งมาจากหน้า Login
  Future getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      UID = preferences.getString('sendUid')!;
      var check = preferences.containsKey('sendUid');
      //print(check);
    });
  }

  @override
  void initState() {
    super.initState();
    getUid();
    //getlike();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      getReply();
    });
  }

  //fucntion เพิ่ม comment
  Future<void> add_reply() async {
    try {
      String uri = "http://192.168.1.46/reru/insertReply.php";
      var res = await http.post(Uri.parse(uri), body: {
        "uid": UID,
        "news_id": widget.list[widget.index]['news_id'],
        "text": replyController.text,
      });
      var respones = json.decode(res.body);
      if (respones["Success"] == "True") {
        String uid = respones["uid"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('sendUid', uid);
        print('Success');
      } else
        print('Fail');
    } catch (e) {
      print(e);
    }
  }

  //fucntion แสดง list comment
  Future<List> getReply() async {
    final uri = "http://192.168.1.6/reru/get_reply.php";
    final response = await http.post(Uri.parse(uri), body: {
      "news_id": widget.list[widget.index]['news_id'],
    });
    var jsondata = json.decode(response.body);
    //print(jsondata);
    return jsondata;
  }

  //function กดไลค์
  // Future<void> Insertlike() async {
  //   var uri = "http://192.168.1.5/reru/insertLike.php";
  //   var res = await http.post(Uri.parse(uri), body: {
  //     "uid": UID,
  //     "news_id": widget.list[widget.index]['news_id'],
  //   });
  // }

  //function แสดงจำนวน like
  // Future<void> getlike() async {
  //   var uri = "http://192.168.1.5/reru/selectLike.php";
  //   var res = await http.post(Uri.parse(uri), body: {
  //     "uid": UID,
  //     "news_id": widget.list[widget.index]['news_id'],
  //   });
  //   if (res.statusCode == 200) {
  //     var data = json.decode(res.body);
  //     setState(() {
  //       isLikeOrDislike = data;
  //     });
  //   }
  //   print(isLikeOrDislike);
  // }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Hero(
                            tag:
                                'package_${widget.list[widget.index]['news_img']}',
                            child: ClipRect(
                              child: InteractiveViewer(
                                maxScale: 20,
                                child: Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        filterQuality: FilterQuality.high,
                                        image: NetworkImage(
                                          
                                            "http://192.168.1.6/reru/" +
                                                widget.list[widget.index]
                                                    ['news_img']),
                                        fit: BoxFit.fill),
                                    //borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(top: 270),
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    child: Text(
                                      widget.list[widget.index]['news_title'],
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          " " +
                                              widget.list[widget.index]
                                                  ['news_date'],
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                        Text("  "),
                                        Icon(
                                          Icons.person,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          " " +
                                              widget.list[widget.index]
                                                  ['username'],
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 220, 220, 220),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                            Text(" " +
                                                widget.list[widget.index]
                                                    ['total_like'])
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 220, 220, 220),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.comment,
                                              color: Colors.blueGrey,
                                            ),
                                            Text(" " +
                                                widget.list[widget.index]
                                                    ['total_comment'])
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 220, 220, 220),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.blueGrey,
                                            ),
                                            Text(" " +
                                                widget.list[widget.index]
                                                    ['total_view'])
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(widget.list[widget.index]['news_detail'])
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ],
        ));
  }
}

//class comment
class ItemList extends StatelessWidget {
  final List list;

  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, i) {
        return ListTile(
          // onTap: () => showDialog<String>(
          //     context: context,
          //     builder: (BuildContext context) => AlertDialog(
          //           title: Text(list[i]['text']),
          //           content: Text("Post : " + list[i]['username']),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () => Navigator.pop(context, 'Cancel'),
          //               child:  Text('แก้ไข'),
          //             ),
          //             TextButton(
          //               onPressed: () => Navigator.pop(context, 'OK'),
          //               child:  Text('ลบ'),
          //             ),
          //             TextButton(
          //               onPressed: () => Navigator.pop(context, 'OK'),
          //               child:  Text('ยกเลิก'),
          //             ),
          //           ],
          //         )),
          tileColor: Color.fromARGB(255, 239, 237, 237),
          leading: Icon(
            Icons.account_circle,
            size: 40,
          ),
          title: Text(
            list[i]['username'],
            style: TextStyle(fontSize: 17),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                list[i]['text'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(list[i]['date'])
            ],
          ),
          isThreeLine: true,
          dense: true,
        );
      },
    );
  }
}
