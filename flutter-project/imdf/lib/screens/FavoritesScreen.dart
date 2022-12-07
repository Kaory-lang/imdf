import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/MovieThumbnail.dart';
import '../widgets/ApiUrl.dart';
import './MovieScreen.dart';

class FavoritesScreen extends StatefulWidget {
  String? uid;

  FavoritesScreen({super.key, this.uid});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState(this.uid);
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<dynamic> _datas = [];
  String? uid;
  List<Widget> thumbnails = <Widget>[];

  _FavoritesScreenState(this.uid);

  void fetch_data() async {
    var userFavs = await http.get(Uri.parse(ApiUrl.url + "/api/favourite/${this.uid}"));
    List<dynamic> tmpData = [];

    if (userFavs.statusCode != 200) return;

    var userFavsJson = json.decode(userFavs.body);

    for (Map<String, dynamic> fav in userFavsJson) {
      var movie = await http.get(
        Uri.parse(ApiUrl.url+"/api/Movie/${fav['favourite_MovieId']}")
      );

      if (movie.statusCode != 200) return;

      tmpData.add(jsonDecode(movie.body));
    }
    
    setState(() => this._datas = tmpData);
    this.generate_thumbnails();
  }

  void generate_thumbnails() {
    List<Widget> tmpThumbnails = <Widget>[];

    if(_datas != null) {
      for(final data in _datas) {
        tmpThumbnails.add(
          new GestureDetector(
            child: MovieThumbnail(data: data, uid: this.uid, refreshAction: this.fetch_data,),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new MovieScreen(data: data, uid: this.uid)),
            ),
          )
        );
      }
    }

    setState(() => this.thumbnails = tmpThumbnails);
  }

  @override
  void initState() {
    fetch_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Favorites Screen"),
        backgroundColor: Colors.grey[900],
      ),
      body: new Container(
        color: Colors.grey[900],
        child: GridView.count(
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 0.5625,
          physics: new BouncingScrollPhysics(),
          crossAxisCount: 3,
          children: this.thumbnails,
        ),
      ),
    );
  }
}

