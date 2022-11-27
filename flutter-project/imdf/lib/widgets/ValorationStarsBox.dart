import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ApiUrl.dart';

class ValorationStarsBox extends StatefulWidget {
  var data;
  String? uid;

  ValorationStarsBox({super.key, this.data, this.uid});

  @override
  _ValorationStarsBoxState createState() => _ValorationStarsBoxState(data: this.data, uid: this.uid);
}

class _ValorationStarsBoxState extends State<ValorationStarsBox> {
  var data;
  String? uid;

  _ValorationStarsBoxState({this.data, this.uid});

  List<Widget> stars = <Widget>[];

  double userValoration = 0;
  String valoration = "0";

  void fetch_valorations() async {
    var response = await http.get(
      Uri.parse(ApiUrl.url+"/api/Vote/${this.data['movie_Id']}")
    );

    if(response.statusCode == 200)
      setState(() => valoration = response.body);

    response = await http.get(
      Uri.parse(ApiUrl.url+"/api/Vote/${this.uid}/${this.data['movie_Id']}")
    );

    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      this.userValoration = jsonData["vote_Valoration"];
      this.change_icon(jsonData["vote_Valoration"]-1);
    }
  }

  void change_valoration() async {
    var voteExist = await http.get(
      Uri.parse(ApiUrl.url+"/api/Vote/${this.uid}/${this.data['movie_Id']}")
    );

    if(voteExist.statusCode == 200) {
      var jsonData = json.decode(voteExist.body);
      jsonData["vote_Valoration"] = this.userValoration;

      var response = await http.put(
        Uri.parse(ApiUrl.url+"/api/Vote/${jsonData['vote_Id']}"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(jsonData),
      );
    } else {
      var response = await http.post(
        Uri.parse(ApiUrl.url+"/api/Vote/"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "vote_MovieId": this.data["movie_Id"],
            "vote_UserId": this.uid,
            "vote_Valoration": this.userValoration
          }
        )
      );
    }
  }

  void change_icon(int star) {
    setState(() => {
      for (int x = star; x >= 0; x--) {
        this.stars[x] = new GestureDetector(
          onTap: () => change_icon(x),
          child: new Icon(Icons.star_outlined),
        ),
      },

      for (int x = 4-star; x > 0; x--) {
        this.stars[star+x] = new GestureDetector(
          onTap: () => change_icon(star+x),
          child: new Icon(Icons.star_border_sharp),
        ),
      },

      this.userValoration = star+1,
      change_valoration()
    });
  }

  @override
  void initState() {
    super.initState();

    this.fetch_valorations();

    for (var x = 0; x < 5; x++) {
      this.stars.add(
        new GestureDetector(
          onTap: () => change_icon(x),
          child: new Icon(Icons.star_border_sharp),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [new Text(this.valoration.toString()), ...this.stars],
    );
  }
}
