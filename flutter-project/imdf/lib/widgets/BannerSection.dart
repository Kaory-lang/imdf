import 'package:flutter/material.dart';

class Banner extends StatelessWidget {
  const Banner({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 100,
      width: 300,
      child: Text("Movie Banner", textAlign: TextAlign.center,),
    );
  }
}
