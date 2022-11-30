import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/MovieThumbnail.dart';
import '../widgets/ApiUrl.dart';
import '../widgets/ApiUrl.dart';
import './AddMovieScreen.dart';
import './MovieScreen.dart';
import './EditGenderScreen.dart';
import './FavoritesScreen.dart';

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

  void popup_menu_options(int option, BuildContext context) {
    if (option == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new AddMovieScreen()),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new AddMovieScreen()),
      );
    }else if (option == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new EditGenderScreen()),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new EditGenderScreen()),
      );
    }else if (option == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new FavoritesScreen(uid: this.uid)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> thumbnails = <Widget>[];

    if(_datas != null) {
      for(final data in _datas) {
        thumbnails.add(
          new GestureDetector(
            child: MovieThumbnail(data: data, uid: this.uid),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new MovieScreen(data: data, uid: this.uid)),
            ),
          )
        );
      }
    }

    if(this.uid == "58NvYoPnPYTQ7rGpAGXfIhIPsRm2") {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("IMDF Main"),
          actions: [
            new IconButton(
              icon: new Icon(Icons.favorite),
              onPressed: () => this.popup_menu_options(3, context)
            ),
            new PopupMenuButton(
              itemBuilder: (context) => [
                new PopupMenuItem(
                  child: new Text("Add Movie"),
                  onTap: () => this.popup_menu_options(1, context)
                ),
                new PopupMenuItem(
                  child: new Text("Edit Genders"),
                  onTap: () => this.popup_menu_options(2, context)
                ),
              ],
            ),
          ]
        ),
        body: GridView.count(
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 0.5625,
          physics: BouncingScrollPhysics(),
          crossAxisCount: 3,
          children: thumbnails,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("IMDF Main"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.favorite),
              onPressed: () => this.popup_menu_options(3, context)
            ),
          ]
        ),
        body: GridView.count(
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 0.5625,
          physics: BouncingScrollPhysics(),
          crossAxisCount: 3,
          children: thumbnails,
        ),
      );
    }
  }
}

