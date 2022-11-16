import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/ApiUrl.dart';
import 'dart:convert';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  List<String> _fields = ["*Name", "Synopsis", "Country", "Release Year", "*Duration",
                        "Valoration", "Director", "Cast", "Cover", "Banner", "*Genders"];

  Map<String, TextEditingController> _textControllers = {};

  List<Widget> _textFields = <Widget>[];

  void validate_fields() async {
    // Parsing the values of the fields
    List<dynamic?> values = <dynamic?>[];

    for(int x = 0; x < this._fields.length; x++) {
      if(this._textControllers[this._fields[x]]?.text == "") values.add(null);
      else values.add(this._textControllers[this._fields[x]]?.text);
    }

    values[3] = int.tryParse("${values[3]}");     // Parse Release Year to Int
    values[4] = int.tryParse("${values[4]}");     // Parse Duration to Int
    values[5] = double.tryParse("${values[5]}");  // Parse Valoration to Double 

    // Errors SnackBars
    final noNullName = SnackBar(
      content: const Text("ERROR!!! No empty name."),
      duration: Duration(seconds: 1),
    );
    final validReleaseYear = SnackBar(
      content: const Text("ERROR!!! Invalid input, only Number(INTEGER) in Release Year."),
      duration: Duration(seconds: 1),
    );
    final validDuration = SnackBar(
      content: const Text("ERROR!!! No null, Number(INTEGER) in *Duration in minutes."),
      duration: Duration(seconds: 1),
    );
    final validValoration = SnackBar(
      content: const Text("ERROR!!! Invalid input, Number(DOUBLE) in Valoration."),
      duration: Duration(seconds: 1),
    );
    final noNullGender = SnackBar(
      content: const Text("ERROR!!! MIN one gender. All need to exist in the Database."),
      duration: Duration(seconds: 1),
    );
    final unknownError = SnackBar(
      content: const Text("ERROR!!! Unknown error."),
      duration: Duration(seconds: 1),
    );

    if(values[0] == null) {
      ScaffoldMessenger.of(context).showSnackBar(noNullName);
      return;
    }
    else if(this._textControllers["Release Year"]?.text != "" && values[3] == null) {
      ScaffoldMessenger.of(context).showSnackBar(validReleaseYear);
      return;
    }
    else if(values[4] == null) {
      ScaffoldMessenger.of(context).showSnackBar(validDuration);
      return;
    }
    else if(this._textControllers["Valoration"]?.text != "" && values[5] == null) {
      ScaffoldMessenger.of(context).showSnackBar(validValoration);
      return;
    }
    else if(values[10] == null) {
      ScaffoldMessenger.of(context).showSnackBar(noNullGender);
      return;
    }

    // Validating existence of genders entered
    var dbGenders = await http.get(Uri.parse(ApiUrl.url + "/api/Gender"));
    List<dynamic> allGenders = json.decode(dbGenders.body);
    List<String> genders = values[10].split(',');
    List<int> validGenders = <int>[];

    for(String gender in genders) {
      gender = gender.trim().toLowerCase();
      bool found = false;

      for(Map<String, dynamic> dbGender in allGenders) {
        if(gender == dbGender["gender_Name"].toLowerCase()) {
          validGenders.add(dbGender["gender_Id"]);
          found = true;
          break;
        }
      }

      if(found) continue;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("ERROR!!! Gender \"${gender}\" doesn't exist in the Database."),
          duration: Duration(seconds: 3),
        )
      );
      return;
    }

    var savedMovie = await http.post(
      Uri.parse(ApiUrl.url + "/api/Movie"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "movie_Name": values[0],
        "movie_Synopsis": values[1],
        "movie_Country": values[2],
        "movie_ReleaseYear": values[3],
        "movie_Duration": values[4],
        "movie_Valoration": values[5],
        "movie_Director": values[6],
        "movie_Cast": values[7],
        "movie_Cover": values[8],
        "movie_Banner": values[9],
      })
    );

    if(savedMovie.statusCode != 201) {
      ScaffoldMessenger.of(context).showSnackBar(unknownError);
      return;
    }

    int movieId = json.decode(savedMovie.body)["movie_Id"];
    List<Map<String, int>> dataBody = [];

    for(int genderId in validGenders) {
      dataBody.add({
        "genderXMovie_GenderId": genderId,
        "genderXMovie_MovieId": movieId,
      });
    }

    var response = await http.post(
      Uri.parse(ApiUrl.url + "/api/GenderXMovie"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(dataBody)
    );

    if(response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(unknownError);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Saved successfully"),
        duration: Duration(seconds: 3),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    this._textControllers =
      Map<String, TextEditingController>.fromIterable(
        this._fields,
        key: (field) => field,
        value: (field) => new TextEditingController()
      );

    for(String field in this._fields) {
      this._textFields.add(
        new Padding(
          padding: EdgeInsets.all(5.0),
          child: new TextField(
            controller: _textControllers[field],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: field,
            ),
          ),
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Movie"),
      ),
      body: ListView(children: [
        ...this._textFields,
        new ElevatedButton(
          child: new Text("Add"),
          onPressed: this.validate_fields,
        ),
      ],),
    );
  }
}
