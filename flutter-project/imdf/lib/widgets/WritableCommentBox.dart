import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ApiUrl.dart';

class WritableCommentBox extends StatefulWidget {
  var data;
  String? uid;

  WritableCommentBox({super.key, this.data, this.uid});

  @override
  _WritableCommentBoxState createState() => _WritableCommentBoxState(data: this.data, uid: this.uid);
}

class _WritableCommentBoxState extends State<WritableCommentBox> {
  var data;
  String? uid;

  _WritableCommentBoxState({this.data, this.uid});

  TextEditingController bodyField = new TextEditingController();

  void post_comment() async {
    var response = await http.post(
      Uri.parse(ApiUrl.url + "/api/Comment/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "comment_Body": bodyField.text,
          "comment_UserId": this.uid,
          "comment_MovieId": this.data["movie_Id"]
        }
      ),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(
          content: const Text("Comment Successfully Posted."),
          duration: Duration(seconds: 3),
        )
      );

      bodyField.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(
          content: const Text("Error posting the comment!!! Comment was't posted."),
          duration: Duration(seconds: 3),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new TextField(
          controller: this.bodyField,
          decoration: new InputDecoration(
            enabledBorder: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey,),
            ),
            labelText: "Comment Body",
            labelStyle: new TextStyle(color: Colors.grey),
          ),
        ),

        new Text(""),
        
        new ElevatedButton(
          child: new Text("Post Comment"),
          onPressed: () => this.post_comment(),
          style: new ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
      ],
    );
  }
}
