import 'package:flutter/material.dart';
import 'package:imdf/widgets/WritableCommentBox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './ApiUrl.dart';

class CommentsSection extends StatefulWidget {
  final String? uid;
  final data;

  const CommentsSection({ super.key, this.data, this.uid});

  @override
  _CommentsSectionState createState() => _CommentsSectionState(data: this.data, uid: this.uid);
}

class _CommentsSectionState extends State<CommentsSection> {
  final String? uid;
  final data;

  _CommentsSectionState({ this.data, this.uid});

  List<Widget> comments = <Widget>[];

  void fetch_comments() async {
    var response = await http.get(
      Uri.parse(ApiUrl.url + "/api/Comment/${this.data['movie_Id']}")
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      for (Map<String, dynamic> field in jsonData) {
        setState(() => {
          this.comments.add(
            new Container(
              decoration: new BoxDecoration(
                color: Colors.grey,
                border: new Border.all(
                  color: Colors.grey,
                ),
                borderRadius: new BorderRadius.all(new Radius.circular(10)),
              ),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: new Text(field["comment_Body"]),
            )
          ),
          this.comments.add(new Text("")),
        });
      }
    } else {
      setState(() => this.comments.add(new Text("Not Comments Yet")));
    }
  }

  @override
  void initState() {
    super.initState();
    fetch_comments();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: new EdgeInsets.all(10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            "COMMENTS:",
            style: new TextStyle(color: Colors.white,),
          ),
          new Text(""),
          new Expanded(
            child: new ListView(
              children: <Widget>[...this.comments],
            ) 
          ),
          new WritableCommentBox(data: this.data, uid: this.uid)
        ],
      ),
    );
  }
}
