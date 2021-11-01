import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/SearchPage/SearchPage.dart';
import 'package:flutter_login_signup/src/Widget/AllMenuSearch/setSearchMenu.dart';
import 'package:flutter_login_signup/src/Widget/AllMenuSearch/setSearchMenu01.dart';

class MenuAllSearch extends StatefulWidget {
  @override
  _MenuAllSearchState createState() => _MenuAllSearchState();
}

class _MenuAllSearchState extends State<MenuAllSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('เลือกการค้นหาที่ท่านสนใจ'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG02.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  MenuSearch(),
                  MenuSearch01(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
