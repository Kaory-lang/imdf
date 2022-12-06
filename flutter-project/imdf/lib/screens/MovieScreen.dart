import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/ApiUrl.dart';
import '../widgets/BannerSection.dart' as banner;
import '../widgets/HeaderSection.dart';
import '../widgets/CommentsSection.dart';
import 'dart:convert';

class MovieScreen extends StatefulWidget {
  final data;
  final String? uid;
  const MovieScreen({super.key, this.data, this.uid});

  @override
  _MovieScreenState createState() => _MovieScreenState(data: this.data, uid: this.uid);
}

class _MovieScreenState extends State<MovieScreen> {
  final data;
  final String? uid;

  _MovieScreenState({this.data, this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Details"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child:banner.Banner(data: this.data),
          ),
          new Expanded(
            flex: 2,
            child: new Header(data: this.data, uid: this.uid),
          ),
          new Expanded(
            flex: 2,
            child: new CommentsSection(data: this.data, uid: this.uid),
          ),
        ]
      ),
    );
  }
}
