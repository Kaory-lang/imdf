import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/MovieThumbnail.dart';
import '../widgets/ApiUrl.dart';
import '../widgets/ApiUrl.dart';
import './AddMovieScreen.dart';
import './MovieScreen.dart';

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
    var fetch = await http.get(Uri.parse(ApiUrl.url+"/api/Movie"));
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
        thumbnails.add(new GestureDetector(
          child: MovieThumbnail(data: data, uid: this.uid),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new MovieScreen(data: data, uid: this.uid)),
          ),
        ));
    }

    if(this.uid == "58NvYoPnPYTQ7rGpAGXfIhIPsRm2") {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("IMDF Main"),
          leading: GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new AddMovieScreen()),
              )
            },
            child: Icon(
              Icons.note_add
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: thumbnails,
        ),
      );
    } else {
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
}

