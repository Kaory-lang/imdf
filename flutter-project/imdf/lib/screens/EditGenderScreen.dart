import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/ApiUrl.dart';
import 'dart:convert';
import './AddGenderScreen.dart';

class EditGenderScreen extends StatefulWidget {
  const EditGenderScreen({super.key});

  @override
  _EditGenderScreenState createState() => _EditGenderScreenState();
}

class _EditGenderScreenState extends State<EditGenderScreen> {
  List<Widget> gendersThumbnails = <Widget>[];

  void fetch_genders() async {
    List<Widget> fetchedGenders = <Widget>[];

    var response = await http.get(
      Uri.parse(ApiUrl.url + "/api/Gender")
    );

    if (response.statusCode != 200) return;

    List<dynamic> jsonData = json.decode(response.body);

    for (Map<String, dynamic> gender in jsonData) {
      fetchedGenders.add(new GenderThumbnail(
          genderId: gender["gender_Id"],
          genderName: gender["gender_Name"],
          refreshAction: this.fetch_genders,
      ));

      fetchedGenders.add(new Text(""));
    }

    setState(() => this.gendersThumbnails = fetchedGenders);
  }

  @override
  void initState() {
    super.initState();
    this.fetch_genders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text("Edit Genders Screen"),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: new Center(
        child: new Container(
          width: 300,
          child: new Column(
            children: <Widget>[
              new Text(""),
              new ElevatedButton(
                child: new Text("Create Gender"),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new AddGenderScreen(refreshAction: this.fetch_genders),
                    )
                  ),
                },
              ),
              new Text(""),
              new Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 50),
                  children: this.gendersThumbnails,
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class GenderThumbnail extends StatelessWidget{
  final genderId;
  final genderName;
  final refreshAction;

  GenderThumbnail({ super.key, this.genderId, this.genderName, this.refreshAction });

  void delete_gender(BuildContext context) async {
    var response = await http.delete(
      Uri.parse(ApiUrl.url + "/api/Gender/${this.genderId}")
    );

    if (response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(
          content: const Text("Gender Deleted Successfully"),
          duration: Duration(seconds: 3),
        )
      );

      this.refreshAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 50,
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              // color: Colors.yellow,
              constraints: new BoxConstraints.expand(),
              child: new Center(
                child: new Text("${genderId}", textAlign: TextAlign.center,),
              ),
              decoration: new BoxDecoration(
                border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
            ),
          ),
          new Expanded(
            flex: 3,
            child: new Container(
              // color: Colors.green,
              child: new Text("  ${genderName}"),
            ),
          ),
          new Expanded(
            flex: 1,
            child: new IconButton(
              icon: new Icon(Icons.delete_rounded),
              onPressed: () => this.delete_gender(context),
              color: Colors.red[900],
            ),
          ),
        ]
      ),
      decoration: new BoxDecoration(
        color: Colors.grey,
        border: new Border.all(
          color: Colors.grey,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(5)),
      ),
    );
  }
}
