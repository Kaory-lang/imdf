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

  void delete_movie() async {
    var response = await http.delete(
      Uri.parse(ApiUrl.url + "/api/Movie/${this.data['movie_Id']}")
    );

    if(response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Movie successfully deleted."),
          duration: Duration(seconds: 3),
        )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error deleting the movie."),
          duration: Duration(seconds: 3),
        )
      );
    }
  }

  void showDialogConfirmation(context) {
    delete_movie();
    Navigator.pop(context);
  }

  void showDialogNegation(context) {
    Navigator.pop(context);
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

    List<Widget> variableAdminContent = <Widget>[];

    TextButton okButton = new TextButton(
      child: Text("Confirm"),
      onPressed: () => showDialogConfirmation(context)
    );

    TextButton cancelButton = new TextButton(
      child: Text("Cancel"),
      onPressed: () => showDialogNegation(context)
    );

    AlertDialog alertDialog = new AlertDialog(
      title: new Text("Alert"),
      content: new Text("Are you sure you want to delete this movie from Database?"),
      actions: [okButton, cancelButton],
    );

    if(this.uid == "58NvYoPnPYTQ7rGpAGXfIhIPsRm2") {
      variableAdminContent = [
        Expanded(
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: favouriteIcon,
            onPressed: () => {
              if(isInFavourites)
                deleteFromFavourites()
              else
                saveInFavourites()
            },
          ),
        ),
        Expanded(
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.delete_rounded),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) => alertDialog
              ),
            },
          ),
        ),
      ];
    } else {
      variableAdminContent = [
        Expanded(
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
      ];
    }

    return new Column(
      children: [
        new Expanded(
          flex: 1,
          child: new Container(
            color: Colors.grey,
            child: imageContent,
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${data['movie_Name']}", overflow: TextOverflow.ellipsis),
                Text("${data['movie_Synopsis']}", overflow: TextOverflow.ellipsis),
                Text("${data['movie_ReleaseYear']}"),
              ],
            ),
          ),
        ),
        new Container(
          color: Colors.red,
          child: new Row(
            children: variableAdminContent,
          )
        ),
        ]
    );
  }
}
