// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print, prefer_const_declarations, unused_import, unnecessary_import, implementation_imports, unused_field, prefer_final_fields, sort_child_properties_last, unused_element

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/screens/addnews.dart';
import 'package:reru/screens/detail_office.dart';
import 'dart:convert';
import 'package:reru/screens/details.dart';
import 'package:url_launcher/url_launcher.dart';

class Office extends StatefulWidget {
  const Office({Key? key}) : super(key: key);

  @override
  State<Office> createState() => _OfficeState();
}

class _OfficeState extends State<Office> {
  Future<List> getData() async {
    final uri = "${Api().domain}//getlist_office.php";
    final response = await http.get(Uri.parse(uri));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: FutureBuilder<List>(
      future: getData(),
      builder: (context, AsyncSnapshot) {
        if (AsyncSnapshot.hasError) print(AsyncSnapshot.error);

        return AsyncSnapshot.hasData
            ? new ItemList(
                list: AsyncSnapshot.requireData,
              )
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    ));
  }
}

class ItemList extends StatelessWidget {
  final List list;

  ItemList({required this.list});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

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
      body: Center(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.perm_contact_calendar, size: 35),
                title:
                    Text(list[i]['office_name'], style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.play_arrow_sharp,color: Colors.blue,),
                onTap: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text(list[i]['office_name']),
                            content: Container(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(child: Text('เบอร์โทรศัพท์  : ')),
                                    Text(list[i]['office_tel'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(child: Text('อีเมล์  : ')),
                                    Text(list[i]['office_email'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(child: Text('เว็บไซต์  : ')),
                                    Text(list[i]['office_web'])
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          child: IconButton(
                                            icon: Icon(Icons.call),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final phone =
                                                  Uri.parse(list[i]['office_tel']);
                                              final url = Uri.parse('tel:$phone');
                                              print(phone);
                                              Future<void> _launchUrl() async {
                                                if (!await launchUrl(url)) {
                                                  throw 'Could not launch $url';
                                                }
                                              }

                                              _launchUrl();
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          child: IconButton(
                                            icon: Icon(Icons.email),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final toEmail =
                                                  Uri.parse(list[i]['office_email']);
                                              final url =
                                                  Uri.parse('mailto:$toEmail');
                                              print(toEmail);
                                              Future<void> _launchUrl() async {
                                                if (!await launchUrl(url)) {
                                                  throw 'Could not launch $url';
                                                }
                                              }

                                              _launchUrl();
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          child: IconButton(
                                            icon: Icon(Icons.web),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final _url =
                                                  Uri.parse(list[i]['office_web']);
                                              print(_url);
                                              Future<void> _launchUrl() async {
                                                if (!await launchUrl(_url)) {
                                                  throw 'Could not launch $_url';
                                                }
                                              }

                                              _launchUrl();
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          ));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
