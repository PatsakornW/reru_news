// ignore_for_file: avoid_print, unnecessary_new, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:reru/screens/list_em.dart';
import 'dart:convert';
import 'package:reru/screens/list_faculty.dart';
import 'package:reru/screens/list_office.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Listbook extends StatefulWidget {
  const Listbook({Key? key}) : super(key: key);

  @override
  State<Listbook> createState() => _ListbookState();
}

class _ListbookState extends State<Listbook> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.perm_contact_calendar, size: 35),
              title: Text('คณะ', style: TextStyle(fontSize: 20)),
              trailing: Icon(Icons.play_arrow,color: Colors.blue),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: Faculty(),
                        type: PageTransitionType.rightToLeftWithFade));
              },
            ),
          ),
          Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.support_agent, size: 35),
              title: Text('หน่วยงาน', style: TextStyle(fontSize: 20)),
              trailing: Icon(Icons.play_arrow,color: Colors.blue),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: Office(),
                        type: PageTransitionType.rightToLeftWithFade));
              },
            ),
          ),
          Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.emergency, size: 35),
              title: Text('โทรฉุกเฉิน', style: TextStyle(fontSize: 20)),
              trailing: Icon(Icons.play_arrow,color: Colors.blue),
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        child: Emer(),
                        type: PageTransitionType.rightToLeftWithFade));
              },
            ),
          ),
        ],
      ),
    ));
  }
}
