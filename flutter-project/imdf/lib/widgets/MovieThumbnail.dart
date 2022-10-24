import 'package:flutter/material.dart';

class MovieThumbnail extends StatelessWidget {
  var data;

  MovieThumbnail({super.key, this.data});

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
                child: Icon(
                  Icons.favorite_border,
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
