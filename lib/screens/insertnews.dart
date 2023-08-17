// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_print, curly_braces_in_flow_control_structures, sort_child_properties_last

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/screens/allnews.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class InsertNews extends StatefulWidget {
  const InsertNews({Key? key}) : super(key: key);

  @override
  State<InsertNews> createState() => _InsertNewsState();
}

class _InsertNewsState extends State<InsertNews> {
  TextEditingController news_title = TextEditingController();
  TextEditingController news_detail = TextEditingController();

  static const items = <String>["ข่าวมหาวิทยาลัย", "ข่าวกิจกรรม", "ข่าวลือ"];
  List<DropdownMenuItem<String>> _myitems = items
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();
  String valueItem = "ข่าวมหาวิทยาลัย";

  File? imagePath;
  String? imageName;
  String? imageData;
  ImagePicker imagePicker = ImagePicker();

  String UID = "";
  Future getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      UID = preferences.getString('sendUid')!;
      var check = preferences.containsKey('sendUid');
      //print(check);
      //log(" getuid = $UID");
    });
  }

  @override
  void initState() {
    super.initState();
    getUid();
  }

  Future<void> uploadImage() async {
    try {
      String uri = "${Api().domain}/insert_app.php";
      // if (imageName != null) {
      //   var res = await http.post(Uri.parse(uri), body: {
      //     "uid": UID,
      //     "news_title": news_title.text,
      //     "news_detail": news_detail.text,
      //     "news_type": valueItem,
      //     "data": imageData,
      //     "name": imageName,
      //   });
      //   log("message");
      //   var respones = json.decode(res.body);
      //   if (respones["Success"] == "True") {
      //     final aleart = SnackBar(
      //       backgroundColor: Colors.blue,
      //       content: Row(
      //         children: [
      //           Text('คำขอเข้าร่วมของคุณกำลังรอการอนุมัติ  '),
      //           Icon(
      //             Icons.done,
      //             color: Colors.white,
      //           )
      //         ],
      //       ),
      //     );
      //     ScaffoldMessenger.of(context).showSnackBar(aleart);
      //     print('Upload Success');
      //   } else {
      //     print('Upload Fail');
      //   }
      // } else {
      //   var res = await http.post(Uri.parse(uri), body: {
      //     "uid": UID,
      //     "news_title": news_title.text,
      //     "news_detail": news_detail.text,
      //     "news_type": valueItem,
      //   });
      //   log("dasdsadasdsa");
      //   var respones = json.decode(res.body);
      //   if (respones["Success"] == "True") {
      //     final aleart = SnackBar(
      //       backgroundColor: Colors.blue,
      //       content: Row(
      //         children: [
      //           Text('คำขอเข้าร่วมของคุณกำลังรอการอนุมัติ  '),
      //           Icon(
      //             Icons.done,
      //             color: Colors.white,
      //           )
      //         ],
      //       ),
      //     );
      //     ScaffoldMessenger.of(context).showSnackBar(aleart);
      //     print('Upload Success');
      //   } else {
      //     print('Upload Fail');
      //   }
      // }
      // var res = await http.post(Uri.parse(uri), body: {
      //   "uid": UID,
      //   "news_title": news_title.text,
      //   "news_detail": news_detail.text,
      //   "news_type": valueItem,
      //   "data": imageData,
      //   "name": imageName,
      // });

      //log('\n UID : $UID \n TITLE : $news_title \n DETAIL : $news_detail \n TYPE : $valueItem  \n IMG_NAME $imageName');

      var res = await http.post(Uri.parse(uri), body: {
        "uid": UID,
        "news_title": news_title.text,
        "news_detail": news_detail.text,
        "news_type": valueItem,
        "data": imageData,
        "name": imageName,
      });
      var respones = json.decode(res.body);
      if (respones["Success"] == "True") {
        final aleart = SnackBar(
          backgroundColor: Colors.blue,
          content: Row(
            children: [
              Text('คำขอเพิ่มข่าวของคุณกำลังรอการอนุมัติ  '),
              Icon(
                Icons.done,
                color: Colors.white,
              )
            ],
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(aleart);
        print('Upload Success');
      } else {
        print('Upload Fail');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getImageCamera() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imagePath = File(getimage!.path);
      imageName = getimage.path.split('/').last;
      imageData = base64Encode(imagePath!.readAsBytesSync());
      print(imagePath);
      print(imageName);
      //print(imageData);
    });
  }

  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imagePath = File(getimage!.path);
      imageName = getimage.path.split('/').last;
      imageData = base64Encode(imagePath!.readAsBytesSync());
      print(imagePath);
      print(imageName);
      //print(imageData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              maxLines: 1,
              controller: news_title,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  label: Text(
                    'หัวข้อข่าว',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              maxLines: 5,
              controller: news_detail,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  label: Text(
                    'รายละเอียดข่าว',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  )),
                  items: _myitems,
                  value: valueItem,
                  onChanged: (e) {
                    setState(() {
                      valueItem = e as String;
                    });
                  },
                ),
              )),
          SizedBox(
            height: 10,
          ),
          imagePath != null
              ? Image.file(imagePath!)
              : Text('ยังไม่เลือกรูปภาพ'),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2,
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.perm_media),
                                    title: Text("เลือกรูปจากอัลบั้ม"),
                                    onTap: getImage,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text("เลือกรูปจากกล้อง"),
                                    onTap: getImageCamera,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.perm_media),
                        label: Text('เลือกรูปภาพ')),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2,
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            uploadImage();
                          });
                        },
                        icon: Icon(Icons.add),
                        label: Text('เพิ่มข่าว')),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }

  void show() => showToast(
        'คำขอเพิ่มข่าวของคุณกำลังรอการอนุมัติ ',
        context: context,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.blue,
        position: StyledToastPosition.bottom,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
      );
  // void showToast() => Fluttertoast.showToast(
  //       msg: "This is Center Short Toast",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //   );

  success(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Container(
        padding: EdgeInsets.all(10),
        height: 40,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 30,
            ),
          ),
          Text(
            'คำขอเพิ่มข่าวของคุณกำลังรอการอนุมัติ  ',
            style: TextStyle(fontSize: 15),
          ),
        ]),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue,
    ));
  }
}
