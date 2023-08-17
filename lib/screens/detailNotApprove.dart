import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/screens/btm_navigation.dart';
import 'package:reru/screens/details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class DetailNotApprove extends StatefulWidget {
  List list;
  int index;
  DetailNotApprove({required this.list, required this.index});

  @override
  State<DetailNotApprove> createState() => _DetailNotApproveState();
}

class _DetailNotApproveState extends State<DetailNotApprove> {
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
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
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
