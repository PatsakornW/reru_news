// ignore_for_file: unnecessary_new, unused_import, prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reru/api/api_search.dart';
import 'package:reru/model/NewsModel.dart';
import 'package:reru/screens/details.dart';
import 'package:reru/screens/detailtest.dart';

import '../api/api_search.dart';

class SearchNews extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {

          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new));
  }

  FetchNews newlist = FetchNews();

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: newlist.getNewsList(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, i) {
            return ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${snapshot.data?[i].newsTitle}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                            context,
                            PageTransition(
                                child: Details(list: newlist.data, index: i),
                                type: PageTransitionType.rightToLeft));
         
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('ค้นหา'),
    );
  }
}
