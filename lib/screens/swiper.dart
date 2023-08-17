// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print, prefer_const_declarations, unused_import, unnecessary_import, implementation_imports, unused_field, prefer_final_fields, sort_child_properties_last, unused_element

import 'package:animations/animations.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/api/api_getdata.dart';
import 'package:reru/screens/addnews.dart';
import 'dart:convert';
import 'package:reru/screens/details.dart';
import 'package:reru/screens/detailtest.dart';
import 'package:reru/screens/swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reru/model/NewsModel.dart';

class Swiperimg extends StatefulWidget {
  const Swiperimg({Key? key}) : super(key: key);

  @override
  State<Swiperimg> createState() => _SwiperimgState();
}

class _SwiperimgState extends State<Swiperimg> {
  @override
  void initState() {
    super.initState();
    _getNews.getNewsList;
  }

  Future<void> _refresh() async {
    setState(() {
      _getNews.getNewsList;
    });
  }

  //ดึงข้อมูล
  Future<List> getData() async {
    final uri = "${Api().domain}/getdata_app.php";
    final response = await http.get(Uri.parse(uri));
    var jsondata = json.decode(response.body);

    return jsondata;
  }

  getNews _getNews = getNews();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<NewsModel>>(
            future: _getNews.getNewsList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.local_fire_department,
                                size: 30,
                                color: Colors.orange,
                              ),
                              Text(
                                'ข่าวมาแรง',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 1),
                              ),
                            ],
                          )),
                    ),
                    CarouselSlider.builder(
                      itemCount: snapshot.data?.length,
                      options: CarouselOptions(
                        height: 300,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder:
                          (BuildContext context, int i, int pageViewIndex) =>
                              Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          //color: Colors.red,

                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: Details(
                                          list: _getNews.data, index: i),
                                      type: PageTransitionType
                                          .rightToLeftWithFade));
                            },
                            child: Card(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black87.withOpacity(0.1),
                                            BlendMode.darken),
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${Api().domain}/" +
                                            '${snapshot.data?[i].newsImg}')),
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
                                            '${snapshot.data?[i].newsType}',
                                            style:
                                                TextStyle(color: Colors.white),
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
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: <Color>[
                                                  Color.fromARGB(
                                                      255, 24, 24, 24),
                                                  Colors.transparent
                                                ])),
                                            child: Stack(children: [
                                              Text(
                                                '${snapshot.data?[i].newsTitle}',
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
                                                          '${snapshot.data?[i].newsDate}')),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.new_releases,
                                size: 30,
                                color: Colors.yellow,
                              ),
                              Text('ข่าวล่าสุด  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      letterSpacing: 1)),
                            ],
                          )),
                    ),
                    CarouselSlider.builder(
                        itemCount: snapshot.data?.length,
                        options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          height: 150,
                          initialPage: 2,
                        ),
                        itemBuilder: (BuildContext context, int i,
                                int realIndex) =>
                            Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: Details(
                                              list: _getNews.data, index: i),
                                          type: PageTransitionType
                                              .rightToLeftWithFade));
                                },
                                child: Card(

                                    //elevation: 5,

                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            colorFilter: ColorFilter.mode(
                                                Colors.black87.withOpacity(0.1),
                                                BlendMode.darken),
                                            fit: BoxFit.cover,
                                            image: NetworkImage("${Api().domain}/" +
                                                '${snapshot.data?[i].newsImg}')),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(
                                                left: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                '${snapshot.data?[i].newsType}',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    bottom: 5,
                                                    right: 5),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end:
                                                            Alignment.topCenter,
                                                        colors: <Color>[
                                                      Color.fromARGB(
                                                          255, 24, 24, 24),
                                                      Colors.transparent
                                                    ])),
                                                child: Stack(children: [
                                                  Text(
                                                    '${snapshot.data?[i].newsTitle}',
                                                    //maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        shadows: [
                                                          Shadow(
                                                            blurRadius: 10,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    24,
                                                                    24,
                                                                    24),
                                                            offset:
                                                                Offset(1, 1),
                                                          )
                                                        ],
                                                        letterSpacing: 0.5,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 30),
                                                    //padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      DateFormat.yMMMMd('en_US')
                                                          .format(DateTime.parse(
                                                              '${snapshot.data?[i].newsDate}')),
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
                            )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.newspaper,
                                size: 30,
                                color: Colors.blue,
                              ),
                              Text('ข่าวทั้งหมด ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      letterSpacing: 1)),
                            ],
                          )),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                            onTap: () {},
                            child: Container(
                                height: 100,
                                margin: const EdgeInsets.all(8),
                                child: Row(children: <Widget>[
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.network(
                                          "${Api().domain}/" +
                                              '${snapshot.data?[i].newsImg}',
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${snapshot.data?[i].newsTitle}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${snapshot.data?[i].newsDetail}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        DateFormat.yMMMMd('en_US').format(
                                            DateTime.parse(
                                                '${snapshot.data?[i].newsDate}')),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ))
                                ])));
                      },
                    ),
                  ]),
                ),
              );
            }),
      ),
    );
  }
}
