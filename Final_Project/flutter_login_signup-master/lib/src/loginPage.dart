import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/User_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/RegisterUser.dart';
import 'package:flutter_login_signup/src/UserAdmin/HomePadeAdmin.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Widget/backgroudlogre.dart';

//DataBase
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Shared
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String Username, Password, Email;

//////////////////////////////////////////////////////////////////////////////////////////////////
  // Widget _backButton() {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.pop(context);
  //     },
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: Row(
  //         children: <Widget>[
  //           Container(
  //             padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
  //             child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
  //           ),
  //           Text('Back',
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
  //         ],
  //       ),
  //     ),
  //   );
  // }
//////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget _entryusername(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              // controller: namectrl,
              onChanged: (value) => Username = value.trim(),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
//////////////////////////////////////////////////////////////////////////////////////////////

  Widget _entrypassword(String title, {bool isPassword = true}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              onChanged: (value) => Password = value.trim(),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
///////////////////////////////////////////////////////////////////////////////////////

  Widget _submitButton() {
    return Container(
      child: Row(children: <Widget>[
        Expanded(
          child: MaterialButton(
            color: Colors.orange[400],
            child: Text('Login',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            onPressed: () {
              if (Username == null ||
                  Username.isEmpty ||
                  Password == null ||
                  Password.isEmpty) {
                normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
              } else {
                checkuser();
              }
              // login();
            },
          ),
        ),
      ]),
    );
  }

  Future<Null> checkuser() async {
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/UserLogin.php?isAdd=true&Username=$Username';
    var response = await Dio().get(url);
    // print('res = $response');

    var result = json.decode(response.data);
    print('result = $result');

    if (result == null) {
      normalDialog(context, 'ท่านไม่ได้เป็นสมาชิกกรุณาทำการสมัคร');
    } else {
      for (var map in result) {
        UserModel usermodel = UserModel.fromJson(map);
        if (Password == usermodel.password) {
          String status = usermodel.status;
          if (status == 'UserNormal') {
            routetoService(HomeScreen(), usermodel);
            Show_Case();
          } else if (status == 'UserShop') {
            routetoService(HomeScreenShop(), usermodel);
            Show_Case();
          } else if (status == 'UserAdmin') {
            routetoService(HomePageAdmin(), usermodel);
          } else {
            normalDialog(context, 'ผิดพลาด กรุณากรอกใหม่ทั้งหมด');
          }
        } else {
          normalDialog(context, 'บัญชีผู้ใช้ / รหัสผิด กรุณากรอกใหม่');
        }
      }
    }
  }

  Widget Show_Case() {
    Fluttertoast.showToast(
        msg: "Login Sccess",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<Null> routetoService(Widget myWidget, UserModel usermodel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('Id_User', usermodel.iDUser);
    preferences.setString('Status', usermodel.status);
    preferences.setString('Username', usermodel.username);
    preferences.setString('Image_Profile', usermodel.imageProfile);
    preferences.setString('Email', usermodel.email);
    preferences.setString('Password', usermodel.password);
    preferences.setString('Token', usermodel.token);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route,
        (route) => false); // ถ้า login แล้วจะไม่สามารถกดกลับได้นอกจาก logout
  }
///////////////////////////////////////////////////////////////////////////////////////////////////

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegisterUserall()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'หากคุณยังไม่ได้เป็นสมาชิก',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
//////////////////////////////////////////////////////////////////////////////////////////////

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryusername("Username"),
        _entrypassword("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login User'),
        backgroundColor: Colors.orange[400],
        centerTitle: true,
      ),
      body: Container(


        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG01.jpg"),
            fit: BoxFit.cover,
          ),
        ),


        height: height,
        child: Stack(
          children: <Widget>[
            // Positioned(child: BackgroundLogin()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 20),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(padding: EdgeInsets.symmetric(vertical: 10)),
                    // SizedBox(height: height * .055),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
            // Positioned(top: 50, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
