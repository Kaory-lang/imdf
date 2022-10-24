import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/MovieThumbnail.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  List<dynamic> _datas = [];

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
        thumbnails.add(MovieThumbnail(data: data));
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

