// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_print, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/screens/addnews.dart';
import 'package:reru/screens/allnews.dart';
import 'package:reru/screens/insertnews.dart';
import 'package:reru/screens/list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'btm_navigation.dart';
//import http package manually

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  late String errormsg;
  late bool error, showprogress;
  late String username, password;

  var _username = TextEditingController();
  var _password = TextEditingController();
  startLogin() async {
    String apiurl = "${Api().domain}/login_app.php";
    var response = await http.post(Uri.parse(apiurl), body: {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
          });
          Navigator.push(
              context,
              PageTransition(
                  child: Navigation_bar(),
                  type: PageTransitionType.rightToLeft));

          //save the data returned from server
          //and navigate to home page
          String uid = jsondata["uid"];
          String username = jsondata["username"];
          //print(uid);
          //print(username);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('sendUid', uid);
          // ตัวส่ง

          //user shared preference to save data
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));

    return Scaffold(
       backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height
                //set minimum height equal to 100% of VH
                ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Container(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                    image: AssetImage("assets/images/reru1.png"),
                    height: 250,
                    width: 250,
                    //fit: BoxFit.cover,
                  ),
                ]),
          ),
          Container(
            child: Text(
              "เข้าสู่ระบบ",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ), //title text
          ),

          Container(
            //show error message here
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(10),
            child: error ? errmsg(errormsg) : Container(),
            //if error == true then show error message
            //else set empty container as child
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _username, //set username controller
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: myInputDecoration(
                label: "ชื่อผู้ใช้",
                icon: Icons.person,
              ),
              onChanged: (value) {
                //set username  text on change
                username = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _password, //set password controller
              style: TextStyle(color: Colors.white, fontSize: 20),
              obscureText: true,
              decoration: myInputDecoration(
                label: "รหัสผ่าน",
                icon: Icons.lock,
              ),
              onChanged: (value) {
                // change password text
                password = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 50,
              width: 150,
              //width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                  setState(() {
                    //show progress indicator on click
                    showprogress = true;
                  });
                  startLogin();
                },
                child: showprogress
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue[100],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 1, 17, 255)),
                        ),
                      )
                    : Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(fontSize: 20),
                      ),
                // if showprogress == true then show progress indicator
                // else show "LOGIN NOW" text
                colorBrightness: Brightness.dark,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                    //button corner radius
                    ),
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.all(10),
          //   margin: EdgeInsets.only(top: 20),
          //   child: InkResponse(
          //       onTap: () {
          //         //action on tap
          //       },
          //       child: Text(
          //         "Forgot Password? Troubleshoot",
          //         style: TextStyle(color: Colors.white, fontSize: 18),
          //       )),
          // )
        ]),
      )),
    );
  }

  InputDecoration myInputDecoration(
      {required String label, required IconData icon}) {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle: TextStyle(color: Colors.white, fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: Colors.white,
          )
          //padding and icon for prefix
          ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.blue, width: 1)), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: Colors.blue.shade200, width: 1)), //focus border

      fillColor: Colors.blue,
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blue,
          border: Border.all(color: Colors.blue.shade300, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}
