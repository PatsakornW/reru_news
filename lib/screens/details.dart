// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import, unnecessary_new, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/api/api_getdata.dart';
import 'package:reru/screens/allnews.dart';
import 'package:reru/screens/deleteReply.dart';
import 'dart:convert';
import 'package:reru/screens/details.dart';
import 'package:reru/screens/editreply.dart';
import 'package:reru/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  List list;
  int index;
  Details({required this.index, required this.list});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _largePhoto = false;
  TextEditingController replyController = TextEditingController();

  Future<void> _refresh() async {
    setState(() {
      getReply();
      _getNews.getNewsList;
      
    });
  }

  @override
  void initState() {
    super.initState();
    getUid();
    getReply();
    _getNews.getNewsList;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      getReply();
      _getNews.getNewsList;
    });
  }

  //clear text
  void clearText() {
    replyController.clear();
  }

  getNews _getNews = getNews();

  String isLikeOrDislike = "";
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

  //fucntion เพิ่ม comment
  Future<void> add_reply() async {
    try {
      String uri = "${Api().domain}/insertReply.php";
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
    final uri = "${Api().domain}/get_reply.php";
    final response = await http.post(Uri.parse(uri), body: {
      "news_id": widget.list[widget.index]['news_id'],
    });
    var jsondata = json.decode(response.body);
    //print(jsondata);
    return jsondata;
  }

  Future<void> insertLike() async {
    try {
      String uri = "${Api().domain}/insertLike.php";
      var res = await http.post(Uri.parse(uri), body: {
        "news_id": widget.list[widget.index]['news_id'],
      });
      var respones = json.decode(res.body);

      if (respones["Success"] == "True") {
        print('Success');
      } else
        print('Fail');
    } catch (e) {
      print(e);
    }
  }

  //function กดไลค์
  Future<void> addLike() async {
    var uri = "${Api().domain}/addLike.php";
    var res = await http.post(Uri.parse(uri), body: {
      "uid": UID,
      "news_id": widget.list[widget.index]['news_id'],
    });
    if (res.statusCode == 200) {
      print('thank');
    }
  }

  // //function แสดงจำนวน like
  Future<void> getlike() async {
    var uri = "${Api().domain}/selectLike.php";
    var res = await http.post(Uri.parse(uri), body: {
      "uid": UID,
      "news_id": widget.list[widget.index]['news_id'],
    });
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        isLikeOrDislike = data;
      });
    }
    print(isLikeOrDislike);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'package_${widget.list[widget.index]['news_img']}',
                          child: ClipRect(
                            child: InteractiveViewer(
                              child: Container(
                                height: 300.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      filterQuality: FilterQuality.high,
                                      image: NetworkImage("${Api().domain}/" +
                                          widget.list[widget.index]['news_img']),
                                      fit: BoxFit.fill),
                                  //borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          //ขนาดกล่อง new_type
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              widget.list[widget.index]['news_type'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          //ขนาดกล่อง title
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text(
                            widget.list[widget.index]['news_title'],
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 2, 0, 0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 15,
                                color: Colors.grey,
                              ),
                              Text(
                                " " +
                                    DateFormat.yMMMMd('en_US').format(
                                        DateTime.parse(widget.list[widget.index]
                                            ['news_date'])),
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text("  "),
                              Icon(
                                Icons.person,
                                size: 15,
                                color: Colors.grey,
                              ),
                              Text(
                                " " + widget.list[widget.index]['username'],
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            isLikeOrDislike == "ONE"
                                ? IconButton(
                                    icon:
                                        Icon(Icons.favorite, color: Colors.red),
                                    onPressed: () {
                                      addLike().whenComplete(() => getlike());
                                    },
                                  )
                                : IconButton(
                                    onPressed: () {
                                      addLike().whenComplete(() => getlike());
                                    },
                                    icon:
                                        Icon(Icons.favorite, color: Colors.red)),
                            // IconButton(
                            //     onPressed: () {
                            //       insertLike();
                            //     },
                            //     icon: Icon(Icons.favorite, color: Colors.red)),
                            Text(
                              widget.list[widget.index]['total_like'],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.chat, color: Colors.blue)),
                            Text(
                              widget.list[widget.index]['total_comment'],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove_red_eye,
                                    color: Colors.grey)),
                            Text(widget.list[widget.index]['total_view']),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: Container(
                            child: Text(
                              widget.list[widget.index]['news_detail'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder<List>(
                          future: getReply(),
                          builder: (context, AsyncSnapshot) {
                            if (AsyncSnapshot.hasError)
                              print(AsyncSnapshot.error);
                            return AsyncSnapshot.hasData
                                ? new ItemList(
                                    list: AsyncSnapshot.requireData,
                                  )
                                : new Center(
                                    child: new CircularProgressIndicator(),
                                  );
                          },
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                    controller: replyController,
                                    decoration: const InputDecoration(
                                        hintText: "แสดงความคิดเห็น....")),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    add_reply();
                                    clearText();
                                  });
                                },
                                icon: Icon(Icons.send),
                                color: Colors.blue)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
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
          onTap: () => 
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("แก้ไข"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              child: Editreply(list[i]['text'],
                                      list[i]['reply_id'], list[i]['uid']),
                              type: PageTransitionType.fade));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("ลบ"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              child: Deletereply(
                                      list[i]['news_id'],list[i]['reply_id'], list[i]['uid']),
                              type: PageTransitionType.fade));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.cancel),
                    title: Text("ยกเลิก"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),          

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
