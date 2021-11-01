import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageModel.dart';
// import 'package:flutter_login_signup/src/HomePage/HomePage.dart';

class MenuSearch01 extends StatefulWidget {
  @override
  _MenuSearch01State createState() => _MenuSearch01State();
}

class _MenuSearch01State extends State<MenuSearch01> {

    Widget _planetThumbnail() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ModelPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
        child: Image(
          image: AssetImage("img/image_Camera.png"),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );
  }

  Widget _planetCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ModelPage()));
      },
      child: Container(
        height: 124.0,
        margin: EdgeInsets.only(left: 46.0),
        child: Center(
          child: Text(
            "ค้นหาด้วยภาพ",
            style: TextStyle(
              color:Colors.white ,
              fontSize: 30.0,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF1565C0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
          left: 24.0,
          right: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            _planetCard(),
            _planetThumbnail(),
          ],
        ));
  }
}

// final planetThumbnail = new Container(
//   margin: new EdgeInsets.symmetric(vertical: 16.0),
//   alignment: FractionalOffset.centerLeft,
//   child: new Image(
//     image: new AssetImage("img/02_logo.png"),
//     height: 92.0,
//     width: 92.0,
//   ),
// );

// final planetCard = new Container(
//   height: 124.0,
//   margin: new EdgeInsets.only(left: 46.0),
//   decoration: new BoxDecoration(
//     color: new Color(0xFF333366),
//     shape: BoxShape.rectangle,
//     borderRadius: new BorderRadius.circular(8.0),
//     boxShadow: <BoxShadow>[
//       new BoxShadow(
//         color: Colors.black12,
//         blurRadius: 10.0,
//         offset: new Offset(0.0, 10.0),
//       ),
//     ],
//   ),
// );