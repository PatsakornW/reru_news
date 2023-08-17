// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/screens/btm_navigation.dart';
import 'package:reru/screens/deleteNews_notapprove.dart';
import 'package:reru/screens/detailNotApprove.dart';
import 'package:reru/screens/details.dart';
import 'package:reru/screens/editmynews_notapprove.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class NotApprove extends StatefulWidget {
  const NotApprove({Key? key}) : super(key: key);

  @override
  State<NotApprove> createState() => _NotApproveState();
}

class _NotApproveState extends State<NotApprove> {
  String UID = "";
  Future getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      UID = preferences.getString('sendUid')!;
      var check = preferences.containsKey('sendUid');
      log(UID);
    });
  }

  @override
  void initState() {
    super.initState();
    getUid();
  }

  Future<List> getNews_NotApprove() async {
    final uri = "${Api().domain}/getMynews_NotApprove.php";
    final response = await http.post(Uri.parse(uri), body: {
      "uid": UID,
    });
    var jsondata = json.decode(response.body);
    print(jsondata);
    return jsondata;
  }

  Future<List> getUser() async {
    final uri = "${Api().domain}/getProfile.php";
    final response = await http.post(Uri.parse(uri), body: {
      "uid": UID,
    });
    var jsondata = json.decode(response.body);
    print(jsondata);
    return jsondata;
  }

  Future<void> _refresh() async {
    setState(() {
      getNews_NotApprove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List>(
          future: getNews_NotApprove(),
          builder: (context, AsyncSnapshot) {
            if (AsyncSnapshot.hasError) print(AsyncSnapshot.error);
            if (!AsyncSnapshot.hasData) {
              return Center(
                child: new Text('TEXT'),
              );
            }
      
            return AsyncSnapshot.hasData
                ? new Listnews(
                    list: AsyncSnapshot.requireData,
                  )
                : new Center(
                    child: new Text('TEXT'),
                  );
          },
        ),
      ),
    );
  }
}

class Listnews extends StatelessWidget {
  final List list;
  Listnews({required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'RERU NEWS',
          style: TextStyle(fontSize: 40, color: Colors.blue,fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 250,
                    child: InkWell(
                      onLongPress: () => showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text("แก้ไข"),
                                    onTap: (){Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: Editmynews_notapprove(
                                                  list[i]['news_id'],
                                                  list[i]['news_title'],
                                                  list[i]['news_detail'],
                                                  list[i]['uid'],
                                                  list[i]['news_type'],
                                                  list[i]['news_img']),
                                              type: PageTransitionType.fade));},
                                  ),
                                  ListTile(
                                     leading: Icon(Icons.delete),
                                    title: Text("ลบ"),
                                    onTap: (){ 
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: DeleteNews_notapprove(
                                                  list[i]['news_id'],
                                                  list[i]['uid']),
                                              type: PageTransitionType.fade));},
                                  ),
                                   ListTile(
                                     leading: Icon(Icons.cancel),
                                    title: Text("ยกเลิก"),
                                    onTap: (){Navigator.pop(context);},
                                  ),
                                ],
                              ),
                            ),
                          ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: DetailNotApprove(list: list, index: i),
                                type: PageTransitionType.rightToLeft));
                  
                      },
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black87.withOpacity(0.1),
                                          BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image: NetworkImage("${Api().domain}/" +
                                          list[i]['news_img'])),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          list[i]['news_type'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5, right: 5),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: <Color>[
                                                Color.fromARGB(255, 24, 24, 24),
                                                Colors.transparent
                                              ])),
                                          child: Stack(children: [
                                            Text(
                                              list[i]['news_title'],
                                              //maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 10,
                                                      color: Color.fromARGB(
                                                          255, 24, 24, 24),
                                                      offset: Offset(1, 1),
                                                    )
                                                  ],
                                                  letterSpacing: 0.5,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 30),
                                              //padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                DateFormat.yMMMMd('en_US')
                                                    .format(DateTime.parse(
                                                        list[i]['news_date'])),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ]),
                                        )),
                                  ],
                                ),
                              ),
                            ]),
                          )),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
