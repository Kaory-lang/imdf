import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './ApiUrl.dart';

class MovieThumbnail extends StatefulWidget {
  var data;
  String? uid;
  MovieThumbnail({super.key, this.data, this.uid});

  @override
  _MovieThumbnail createState() => _MovieThumbnail(this.data, this.uid);
}

class _MovieThumbnail extends State<MovieThumbnail> {
  var data;
  String? uid;
  bool isInFavourites = false;

  Icon favouriteIcon = Icon(Icons.favorite_border);

  _MovieThumbnail(this.data, this.uid);

  void checkIsInFavourites() async {
    var fetch = await http.get(
      Uri.parse(ApiUrl.url+"/api/Favourite/${this.uid}/${this.data['movie_Id']}"),
    );

    fetch.body == "true"
        ? setState(() => {
            favouriteIcon = Icon(Icons.favorite),
            isInFavourites = true
        })
        : setState(() => {
            favouriteIcon = Icon(Icons.favorite_border),
            isInFavourites = false
        });
  }

  void saveInFavourites() async {
    var response = await http.post(
      Uri.parse(ApiUrl.url+"/api/Favourite/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"favourite_MovieId": this.data["movie_Id"], "favourite_UserId": this.uid})
    );

    checkIsInFavourites();
  }

  void deleteFromFavourites() async {
    var response = await http.delete(
      Uri.parse(ApiUrl.url+"/api/Favourite/${this.uid}/${this.data['movie_Id']}"),
    );

    if(response.statusCode == 204) {
      checkIsInFavourites();
    }
  }

  @override
  void initState() {
    checkIsInFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width * 0.22;
    
    Widget imageContent = Icon(
                            Icons.hide_image_outlined,
                          );

    if(data != null) {
      if(data["movie_Cover"] != null)
        imageContent = Image.network(data["movie_Cover"]);
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: size,
                height: size,
                color: Colors.grey,
                child: imageContent,
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: size,
                height: size,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("${data['movie_Name']}"),
                    Text("${data['movie_Synopsis']}", overflow: TextOverflow.ellipsis),
                    Text("${data['movie_ReleaseYear']}"),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: size,
                height: size,
                color: Colors.red,
                child: IconButton(
                  icon: favouriteIcon,
                  onPressed: () => {
                    if(isInFavourites)
                      deleteFromFavourites()
                    else
                      saveInFavourites()
                  },
                ),
              ),
            ),
          ]
        ),
        SizedBox(width: 20, height: 20),
      ],
    );
  }
}
