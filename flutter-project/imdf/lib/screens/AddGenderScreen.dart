import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/ApiUrl.dart';
import 'dart:convert';

class AddGenderScreen extends StatefulWidget {
  const AddGenderScreen({super.key});

  @override
  _AddGenderScreenState createState() => _AddGenderScreenState();
}

class _AddGenderScreenState extends State<AddGenderScreen> {
  TextEditingController genderNameController = new TextEditingController();
  
  void save_gender() async {
    var response = await http.post(
      Uri.parse(ApiUrl.url + "/api/Gender/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"gender_Name": genderNameController.text})
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(
          content: const Text("Gender Saved Successfully"),
          duration: Duration(seconds: 3),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Add Gender Screen"),
      ),
      body: new Center(
        child: new Container(
          width: 300,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(
                controller: genderNameController,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  labelText: "Gender Name",
                ),
              ),
              
              new ElevatedButton(
                child: new Text("Save"),
                onPressed: () => save_gender(),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
