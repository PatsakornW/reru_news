// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:reru/screens/btm_navigation.dart';
import 'package:reru/screens/allnews.dart';
import 'package:reru/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(       
      
        textTheme:GoogleFonts.kanitTextTheme(Theme.of(context).textTheme),
        //primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //darkTheme: ThemeData.dark(),
      home: LoginPage(), 
    );
  }
}


 