import 'package:flutter/material.dart';

class Banner extends StatelessWidget {
  var data;

  Banner({ super.key, this.data });

  @override
  Widget build(BuildContext context) {
    Widget imageContent = Icon(
                            Icons.hide_image_outlined,
                          );

    if(data != null) {
      if(data["movie_Banner"] != null) {
        imageContent = new Image.network(
          data["movie_Banner"],
          fit: BoxFit.cover,
        );
      }
    }

    return Container(
      color: Colors.grey,
      height: 100,
      width: 300,
      child: imageContent,
      constraints: new BoxConstraints.expand(),
    );
  }
}
