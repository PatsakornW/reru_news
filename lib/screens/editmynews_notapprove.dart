
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../api/all_api.dart';

class Editmynews_notapprove extends StatefulWidget {
  String uid;
  String news_id;
  String news_title;
  String news_detail;
  String news_type;
  String news_img;
  Editmynews_notapprove(this.news_id, this.news_title, this.news_detail, this.uid,
      this.news_type, this.news_img);

  @override
  State<Editmynews_notapprove> createState() => _Editmynews_notapproveState();
}

class _Editmynews_notapproveState extends State<Editmynews_notapprove> {
  TextEditingController news_title_c = TextEditingController();
  TextEditingController news_detail_c = TextEditingController();

  String UID = "";

  //fucntion รับ uid ที่ส่งมาจากหน้า Login
  Future getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      UID = preferences.getString('sendUid')!;
      var check = preferences.containsKey('sendUid');

      print(check);
      print(UID);
    });
  }

  File? imagePath;
  String? imageName;
  String? imageData;
  ImagePicker imagePicker = ImagePicker();

  Future<void> updateNews() async {
    try {
      String uri = "${Api().domain}/editmynews.php";
      var res = await http.post(Uri.parse(uri), body: {
        "news_id": widget.news_id,
        "news_title": news_title_c.text,
        "news_detail": news_detail_c.text,
        "news_type": valueItem,
        "data": imageData,
        "name": imageName,
        "uid": UID
      });
      var jsondata = jsonDecode(res.body);
      print(res);
      if (jsondata["Success"] == 'True') {
        Navigator.pop(context);
        print('update success');
        setState(() {
          //widget.text;
        });
      } else {
        print('update faild');
      }
    } catch (e) {
      print(e);
    }
    ;
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
  void initState() {
    // TODO: implement initState
    news_title_c.text = widget.news_title;
    news_detail_c.text = widget.news_detail;
    widget.news_id;
    widget.news_type;
    widget.uid;
    widget.news_img;
    getUid();

    super.initState();
  }

  void clearText() {
    news_title_c.clear();
    news_detail_c.clear();
  }

  String valueItem = "ข่าวมหาวิทยาลัย";

  final items = ["ข่าวมหาวิทยาลัย", "ข่าวกิจกรรม", "ข่าวลือ"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Column(
          children: <Widget>[
            TextFormField(
              maxLines: 1,
              controller: news_title_c,
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                maxLines: 5,
                controller: news_detail_c,
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
              padding: const EdgeInsets.only(top: 15),
              child: DropdownButton(
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                        child: Text(item), value: item))
                    .toList(),
                onChanged: (e) {
                  setState(() {
                    valueItem = e as String;
                  });
                },
                value: valueItem,
              ),
            ),
            imagePath != null
              ? SizedBox(
              width: 130,
              height: 130,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.grey.shade200,
                backgroundImage:
                imagePath != null ? FileImage(imagePath!) : null,
                   
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(
                            Icons.camera_alt_sharp,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
              : SizedBox(
              width: 130,
              height: 130,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.grey.shade200,
                backgroundImage:
                //imagePath != null ? FileImage(imagePath!) : null
                    NetworkImage("${Api().domain}/" + widget.news_img),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(
                            Icons.camera_alt_sharp,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        content: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    updateNews();
                  },
                  child: Text('แก้ไข'),
                ),
                TextButton(
                  onPressed: () => clearText(),
                  child: Text("ลบ"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text('ยกเลิก'),
                ),
              ],
            )
          ],
        ));
    
  }
}