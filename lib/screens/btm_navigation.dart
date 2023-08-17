// ignore_for_file: prefer_const_constructors, prefer_final_fields, duplicate_import, camel_case_types, avoid_unnecessary_containers, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_new

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/api/api_getdata.dart';
import 'package:reru/api/api_getuser.dart';
import 'package:reru/main.dart';
import 'package:reru/model/NewsModel.dart';
import 'package:reru/screens/mynews.dart';
import 'package:reru/screens/allnews.dart';
import 'package:reru/screens/addnews.dart';
import 'package:flutter/material.dart';
import 'package:reru/screens/insertnews.dart';
import 'package:reru/screens/list.dart';
import 'package:reru/screens/list_faculty.dart';
import 'package:reru/screens/login.dart';
import 'package:reru/screens/mynews_notapprove.dart';
import 'package:reru/screens/search.dart';
import 'package:reru/screens/swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:bottom_bar/bottom_bar.dart';

class Navigation_bar extends StatefulWidget {
  const Navigation_bar({Key? key}) : super(key: key);

  @override
  State<Navigation_bar> createState() => Navigation_barState();
}

class Navigation_barState extends State<Navigation_bar> {
  //คุม bottom_bar
  int _selectedIndex = 0;
  final _pageController = PageController();

  //รับค่า uid จากหน้า login
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

  Future<List> getUser() async {
    final uri = "${Api().domain}/getProfile.php";
    final response = await http.post(Uri.parse(uri), body: {
      "uid": UID,
    });
    var jsondata = json.decode(response.body);
    return jsondata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        backgroundColor: Color.fromARGB(255, 234, 234, 234),
        height: 60,
        textStyle: TextStyle(fontWeight: FontWeight.w700),
        selectedIndex: _selectedIndex,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _selectedIndex = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.newspaper),
            title: Text('News'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: Icon(Icons.add),
            title: Text('Add'),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.list),
            title: Text('List'),
            backgroundColorOpacity: 0.1,
            activeColor: Colors.blue,
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<List>(
          future: getUser(),
          builder: (context, AsyncSnapshot) {
            if (AsyncSnapshot.hasError) print(AsyncSnapshot.error);

            return AsyncSnapshot.hasData
                ? new User(
                    list: AsyncSnapshot.requireData,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchNews());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ))
            ],
            title: const Text(
              'RERU NEWS',
              style: TextStyle(fontSize: 40, color: Colors.blue,fontWeight: FontWeight.bold),
            ),
          )
        ],
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            Allnews(),
            InsertNews(),
            Listbook(),
          ],
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }
}

class User extends StatelessWidget {
  final List list;
  User({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                color: Colors.blue,
                width: double.infinity,
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/cat3.jpg'),
                        ),
                      ),
                    ),
                    Text(
                      list[i]['username'],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      list[i]['email'],
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                top: 15,
              )),
              Container(
                child: Column(
                  // shows the list of menu drawer
                  children: [
                    // InkWell(
                    //   child: Text('test'),
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         PageTransition(
                    //             child: Swiperimg(),
                    //             type: PageTransitionType.rightToLeft));
                    //   },
                    // ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Mynews(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'ข่าวของฉัน',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: NotApprove(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.info,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'ข่าวรออนุมัติ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('sendUid');
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: LoginPage(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.logout,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'ออกจากระบบ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
