import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/RegisterUser.dart';
import 'package:flutter_login_signup/src/UserAdmin/HomePadeAdmin.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/loginPage.dart';

//Test
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    checkPreFerance();
  }

  Future<Null> checkPreFerance() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        if (event != null) {
          String uid = event.uid;
          await FirebaseFirestore.instance
              .collection('user')
              .doc(uid)
              .snapshots()
              .listen((event) {});
          print('Firebase :สำเร็จ');
        } else {
          print('error');
        }
      });
    });

    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      String token = await firebaseMessaging.getToken();
      print('token is : $token');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String checkLoginType = preferences.getString(
          'Status'); //หลังจาก login ครั้งแรกแล้ว ถ้าเข้ามาครั้งต่อไปจะไปหน้าที่ login เข้ามาก่อนหน้านี้แล้วจำ Id & Password
      String idLogin = preferences.getString('Id_User');
      print('idlogin = $idLogin');

      if (idLogin != null && idLogin.isNotEmpty) {
        String url =
            '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/EditToken.php?isAdd=true&ID_User=$idLogin&Token=$token';
        await Dio()
            .get(url)
            .then((value) => print(' Update Token Success by ID_user '));
        String urluptoken = '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/uptokeninfaver.php?isAdd=true&ID_User=$idLogin&Token_User=$token';
         await Dio()
            .get(urluptoken)
            .then((value) => print(' Update Token faver suc '));
      }
      // FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      // String token = await firebaseMessaging.getToken();
      // print('token is : $token');

      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // String checkLoginType = preferences.getString(
      //     'Status'); //หลังจาก login ครั้งแรกแล้ว ถ้าเข้ามาครั้งต่อไปจะไปหน้าที่ login เข้ามาก่อนหน้านี้แล้วจำ Id & Password
      if (checkLoginType != null && checkLoginType.isNotEmpty) {
        if (checkLoginType == 'UserNormal') {
          routeToService(HomeScreen());
        } else if (checkLoginType == 'UserShop') {
          routeToService(HomeScreenShop());
        } else if (checkLoginType == 'UserAdmin') {
          routeToService(HomePageAdmin());
        } else {
          normalDialog(context, 'ประเภทผู้ใช้ผิดพลาด');
        }
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        // LoginPage
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.orange[700]),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegisterUserall()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.orange[700]),
        child: Text(
          'Register',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  // Widget _label() {
  //   return Container(
  //       margin: EdgeInsets.only(top: 40, bottom: 20),
  //       child: Column(
  //         children: <Widget>[
  //           Text(
  //             'Quick login with Touch ID',
  //             style: TextStyle(color: Colors.white, fontSize: 17),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Icon(Icons.fingerprint, size: 90, color: Colors.white),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Text(
  //             'Touch ID',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 15,
  //               decoration: TextDecoration.underline,
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  // Widget _title() {
  //   return RichText(
  //     textAlign: TextAlign.center,
  //     text: TextSpan(
  //         text: 'd',
  //         style: GoogleFonts.portLligatSans(
  //           textStyle: Theme.of(context).textTheme.display1,
  //           fontSize: 30,
  //           fontWeight: FontWeight.w700,
  //           color: Colors.white,
  //         ),
  //         children: [
  //           TextSpan(
  //             text: 'ev',
  //             style: TextStyle(color: Colors.black, fontSize: 30),
  //           ),
  //           TextSpan(
  //             text: 'rnz',
  //             style: TextStyle(color: Colors.white, fontSize: 30),
  //           ),
  //         ]),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height,

            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/icon_test01.png"),
                    fit: BoxFit.cover)),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(5)),
            //     boxShadow: <BoxShadow>[
            //       BoxShadow(
            //           color: Colors.grey.shade200,
            //           offset: Offset(2, 4),
            //           blurRadius: 5,
            //           spreadRadius: 2)
            //     ],
            //     gradient: LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         colors: [Color(0xfffbb448), Color(0xffe46b10)])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // _title(),
                SizedBox(
                  height: 375,
                ),
                _submitButton(),
                SizedBox(
                  height: 30,
                ),
                _signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
