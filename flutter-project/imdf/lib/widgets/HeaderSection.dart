import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './ApiUrl.dart';
import './ValorationStarsBox.dart';

class Header extends StatefulWidget {
  var data;
  String? uid;
  Header({super.key, this.data, this.uid});

  @override
  _HeaderState createState() => _HeaderState(this.data, this.uid);
}

class _HeaderState extends State<Header> {
  final data;
  String? uid;
  _HeaderState(this.data, this.uid);

  String gendersText = "";

  // Get genders
  void fetch_genders() async {
    var response = await http.get(
      Uri.parse(ApiUrl.url + "/api/GenderXMovie/${this.data['movie_Id']}")
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      for(Map<String, dynamic> gender in jsonData) {
        var response2 = await http.get(
          Uri.parse(ApiUrl.url + "/api/Gender/${gender['genderXMovie_GenderId']}")
        );

        if (response2.statusCode == 200) {
          Map<String, dynamic> jsonData2 = json.decode(response2.body);
          setState(() => {
            if (gendersText != "") gendersText += ", ",
            gendersText += jsonData2['gender_Name'],
          });
        }
      }

    }
  }

  @override
  void initState() {
    fetch_genders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String titles = this.data["movie_Name"];
    titles += "  •  (${this.data['movie_ReleaseYear']})  •  (${gendersText})";

    List<String> movieDuration= (this.data["movie_Duration"]/60).toStringAsFixed(2).split('.');

    String othData = "Duration: ${movieDuration[0]}:${movieDuration[1]} Hours.";
    othData += "\n--Director: ${this.data['movie_Director']}.";
    othData += "\n--Cast: ${this.data['movie_Cast']}.";
    othData += "\n--Country: ${this.data['movie_Country']}.";
    othData += "\n\n--Synopsis: ${this.data['movie_Synopsis']}";

    return Container(
      color: Colors.grey[900],
      height: 100,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  titles,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
                new Text(""),
                new Expanded(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: new Text(
                      othData,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          new Expanded(
            child: new Container(
              child: ValorationStarsBox(data: this.data, uid: this.uid)
            ),
          ),
        ],
      ),
    );
  }
}
