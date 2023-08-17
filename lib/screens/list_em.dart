// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print, prefer_const_declarations, unused_import, unnecessary_import, implementation_imports, unused_field, prefer_final_fields, sort_child_properties_last, unused_element

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:reru/api/all_api.dart';
import 'package:reru/screens/addnews.dart';
import 'dart:convert';
import 'package:reru/screens/details.dart';
import 'package:url_launcher/url_launcher.dart';

class Emer extends StatefulWidget {
  const Emer({Key? key}) : super(key: key);

  @override
  State<Emer> createState() => _EmerState();
}

class _EmerState extends State<Emer> {
  Future<List> getData() async {
    final uri = "${Api().domain}//getlist_em.php";
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
               
                title: Text(list[i]['em_name'], style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.call,color: Colors.blue),
                onTap: () {
                  final phone = Uri.parse(list[i]['em_tel']);
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
            );
          },
        ),
      ),
    );
  }
}
