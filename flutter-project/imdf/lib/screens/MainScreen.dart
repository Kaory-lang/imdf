import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/MovieThumbnail.dart';

class MainScreen extends StatefulWidget {
  String? uid;

  MainScreen({super.key, this.uid});

  @override
  _MainScreen createState() => _MainScreen(this.uid);
}

class _MainScreen extends State<MainScreen> {
  List<dynamic> _datas = [];
  String? uid;

  _MainScreen(this.uid);

  void fetch_data() async {
    var fetch = await http.get(Uri.parse("http://localhost:7265/api/Movie"));
    setState(() => _datas = jsonDecode(fetch.body));
  }

  @override
  void initState() {
    fetch_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> thumbnails = <Widget>[];

    if(_datas != null) {
      for(final data in _datas)
        thumbnails.add(MovieThumbnail(data: data, uid: this.uid));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("IMDF Main"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: thumbnails,
      ),
    );
  }
}

