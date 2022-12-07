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
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: new Center(
        child: new Container(
          width: 300,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(
                style: new TextStyle(color: Colors.white),
                controller: genderNameController,
                decoration: InputDecoration(
                  enabledBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey,),
                  ),
                  labelText: "Gender Name",
                  labelStyle: new TextStyle(color: Colors.grey),
                ),
              ),

              new Text(""),
              
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
