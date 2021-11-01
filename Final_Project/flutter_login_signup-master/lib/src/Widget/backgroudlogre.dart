import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'customClipper.dart';

class BackgroundLogin extends StatelessWidget {
  const BackgroundLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/git01.gif"),
              fit: BoxFit.cover)
              ),
      )
    );
  }
}
