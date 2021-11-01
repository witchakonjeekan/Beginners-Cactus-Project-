import 'package:flutter/material.dart';

import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageModel.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'src/welcomePage.dart';

//test

void main() {
  runApp(MyApp());
  // HttpOverrides.global = new MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      // home: ModelPage01(),
    );
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
