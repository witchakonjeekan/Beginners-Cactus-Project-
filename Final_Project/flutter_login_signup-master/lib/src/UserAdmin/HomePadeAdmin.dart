import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/UserAdmin/banshop.dart';
import 'package:flutter_login_signup/src/UserAdmin/checkreport.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  String username, status;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('Username');
      status = preferences.getString('Status');
    });
  }

  Future<Null> SingoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Fluttertoast.showToast(
        msg: "Logout Admin Succes",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    // ล้าง Acccout ที่เข้ามาให้หมด// เมื่อทำการล้าง Acccout แล้วจะทำการปิดแอปพลิเคชั่น
  }

  Widget nameuser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$username' == null ? 'Error' : 'ชื่อ : $username',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        Text(
          'สถานะ : $status',
          style: TextStyle(
            fontSize: 19,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget buttonpage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // RaisedButton(
        //     onPressed: () => {},
        //     color: Colors.blue,
        //     child: Text(
        //       'AddData Cactus',
        //       style: TextStyle(color: Colors.white),
        //     )),
        // SizedBox(height: 20),
        RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportPage()),
              );
            },
            color: Colors.blue,
            child: Text(
              'ตรวจสอบร้านค้าที่โดนระงับ',
              style: TextStyle(color: Colors.white,fontSize: 20),
            )),
            SizedBox(height: 20,),
                   RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BanPage()),
              );
            },
            color: Colors.blue,
            child: Text(
              'จัดการร้านค้าทั้งหมด',
              style: TextStyle(color: Colors.white,fontSize: 20),
            )),
      ],
    );
  }

  Widget logout() {
    return RaisedButton(
        onPressed: () {
          SingoutUser();
        },
        color: Colors.blue,
        child: Text(
          'Logout',
          style: TextStyle(color: Colors.white,fontSize: 20),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG01.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 200,),
                nameuser(),
                SizedBox(height: 50),
                buttonpage(),
                SizedBox(height: 50),
                logout()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
