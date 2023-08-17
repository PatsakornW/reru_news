// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_field, avoid_print, curly_braces_in_flow_control_structures, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class Addnews extends StatefulWidget {
  
  const Addnews({Key? key}) : super(key: key);

  @override
  State<Addnews> createState() => _AddnewsState();
}

class _AddnewsState extends State<Addnews> {
  TextEditingController news_title = TextEditingController();
  TextEditingController news_detail = TextEditingController();
  TextEditingController news_type = TextEditingController();




  static const items = <String>["มหาวิทยาลัย", "กิจกรรม"];

  List<DropdownMenuItem<String>> _myitems = items
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();

  String valueItem = "มหาวิทยาลัย";

  File? imagePath;
  String? imageName;
  String? imageData;

  ImagePicker imagePicker = ImagePicker();

  Future<void> uploadImage() async {
    try {
      String uri = "http://192.168.1.4/reru/add_app.php";
      var res = await http.post(Uri.parse(uri), body: {
        "news_title": news_title.text,
        "news_detail": news_detail.text,
        "news_type" : valueItem,
        "name": imageName,
        "img": imageData
      });

      var respones = json.decode(res.body);
      if (respones["Success"] == "True") {
        print('Upload Success');
      } else
        print('Upload Fail');
    } catch (e) {
      print(e);
    }
  }

  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imagePath = File(getimage!.path);
      imageName = getimage.path.split('/').last;
      imageData = base64Encode(imagePath!.readAsBytesSync());
      print(imagePath);
      print(imageName);
      print(imageData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              controller: news_title,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  label: Text('หัวข้อข่าว')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              controller: news_detail,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  label: Text('รายละเอียดข่าว')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child:DropdownButtonFormField(items: _myitems,
                        value: valueItem,
                        onChanged: (e) {
                          setState(() {
                            valueItem = e as String;
                          });
                        },)
          ),
          
          SizedBox(
            height: 10,
          ),
          // SizedBox(
          //               width: 130,
          //               height: 130,
          //               child: CircleAvatar(
          //                 radius: 5,
          //                 backgroundColor: Colors.grey.shade200,
          //                 backgroundImage: imagePath != null ? FileImage(imagePath!) : null,
          //                 child: Stack(
          //                   children: [
          //                     Positioned(
          //                       bottom: 5,
          //                       right: 5,
          //                       child: GestureDetector(
          //                         onTap: getImage,
          //                         child: Container(
          //                           height: 50,
          //                           width: 50,
          //                           decoration: BoxDecoration(
          //                             color: Colors.blue.shade400,
          //                             border: Border.all(color: Colors.white, width: 3),
          //                             borderRadius: BorderRadius.circular(25),
          //                           ),
          //                           child: const Icon(
          //                             Icons.camera_alt_sharp,
          //                             color: Colors.white,
          //                             size: 25,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
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
                          elevation: 5,
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () {
                          getImage();
                        },
                        icon: Icon(Icons.perm_media),
                        label: Text('เลือกรูปภาพ')),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            uploadImage();
                          });
                        },
                        icon: Icon(Icons.add),
                        label: Text('เพิ่มข่าว')),
                  )
                ]),
          )
        ]),
      ),
    );
  }
}
