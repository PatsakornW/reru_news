// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Faculty_Detail extends StatefulWidget {
  List list;
  int index;
  Faculty_Detail({required this.index, required this.list});

  @override
  State<Faculty_Detail> createState() => _Faculty_DetailState();
}

class _Faculty_DetailState extends State<Faculty_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Text(
            'RERU NEWS',
            style: TextStyle(fontSize: 40, color: Colors.blue,fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.list[widget.index]['list_name'],
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.list[widget.index]['list_tel'],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        widget.list[widget.index]['list_email'],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(widget.list[widget.index]['list_web'])),
                      Text(
                        widget.list[widget.index]['list_web'],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.list[widget.index]['list_tel'],
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              //await FlutterPhoneDirectCaller.callNumber(
                              //'+12313');
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
