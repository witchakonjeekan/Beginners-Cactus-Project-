import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
// import 'package:flutter_login_signup/src/Wait_database/test2.dart';

class viewshop extends StatefulWidget {
  @override
  _viewshopState createState() => _viewshopState();
}

class _viewshopState extends State<viewshop> {
  Widget _shopmanage() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amber[600],
        ),
        child: Center(
            child: Text(
          'จัดการหน้าร้านค้า',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _Gymnocalycium() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amber[600],
        ),
        child: Center(
            child: Text(
          'Gymnocalycium',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _Astrophytum() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amber[600],
        ),
        child: Center(
            child: Text(
          'Astrophytum',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _Coryphantha() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amber[600],
        ),
        child: Center(
            child: Text(
          'Coryphantha',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _Lophophora() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amber[600],
        ),
        child: Center(
            child: Text(
          'Lophophora',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _Mammillaria() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amber[600],
        ),
        child: Center(
            child: Text(
          'Mammillaria',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
    );
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('เลือกการค้นหาที่ท่านสนใจ'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: <Widget>[
          _shopmanage(),
          SizedBox(
            height: 13,
          ),
          _Gymnocalycium(),
          SizedBox(
            height: 13,
          ),
          _Astrophytum(),
          SizedBox(
            height: 13,
          ),
          _Coryphantha(),
          SizedBox(
            height: 13,
          ),
          _Lophophora(),
          SizedBox(
            height: 13,
          ),
          _Mammillaria(),
        ],
      ),
    );
  }
}
