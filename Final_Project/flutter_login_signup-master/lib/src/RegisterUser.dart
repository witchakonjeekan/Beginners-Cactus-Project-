import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/UserModel_FB.dart';
import 'package:flutter_login_signup/src/Model/User_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/backgroudlogre.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUserall extends StatefulWidget {
  @override
  _RegisterUserallState createState() => _RegisterUserallState();
}

class _RegisterUserallState extends State<RegisterUserall> {
  File imageFile;
  final picker = ImagePicker();
  String chooseType, username, email, password, passwordcon;
  CollectionReference _AdddatatoFirebase =
      FirebaseFirestore.instance.collection("user");

  // void initState() {
  //   super.initState();
    // normalDialog(context, 'กรุณาใส่ภาพ');
  // }

  @override
//// เลือกรูปภาพ ///////////////////////////////////////////////////////////////////////////////////////////////
  Widget _title() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: imageFile == null
                ? AssetImage('img/user_logo01.png')
                : FileImage(File(imageFile.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((build) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.orange[400],
                size: 28.0,
              ),
            ),
          )
        ],
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: <Widget>[
        Text(
          "Choose Profile photo",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.camera),
            onPressed: () {
              takePhoto(ImageSource.camera);
            },
            label: Text("Camera"),
          ),
          FlatButton.icon(
            onPressed: () {
              takePhoto(ImageSource.gallery);
            },
            icon: Icon(Icons.image),
            label: Text("Gallery"),
          ),
        ])
      ]),
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    setState(() {
      imageFile = pickedFile;
    });
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Username ///////////////////////////////////////////////////////////////////////////////////////////////
  Widget _entryFieldUsername(String title) {
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
            onChanged: (value) => username = value.trim(), //
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_box,
                ),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////
  /// Email///////////////////////////////////////////////////////////////////////////////////////////////
  Widget _entryFieldEmail(String title) {
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
            onChanged: (value) => email = value.trim(),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                ),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Password////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _entryFieldPassword(String title) {
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
            obscureText: true,
            onChanged: (value) => password = value.trim(),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

  Widget _entryFieldPasswordcon(String title) {
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
            obscureText: true,
            onChanged: (value) => passwordcon = value.trim(),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////////////

///// Choose Type ///////////////////////////////////////////////////////////////////////////////
  Widget userType() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 'UserNormal',
          groupValue: chooseType,
          onChanged: (value) {
            setState(() {
              chooseType = value;
            });
          },
        ),
        Text('ผู้ใช้งานทั่วไป')
      ],
    );
  }

  Widget shopType() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 'UserShop',
          groupValue: chooseType,
          onChanged: (value) {
            setState(() {
              chooseType = value;
            });
          },
        ),
        Text('ผู้ใช้งานร้านค้า')
      ],
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<Null> uploadDataUser() async {
    String urluploadImage =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/UploadimageUser.php';

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'PageShop$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(imageFile.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urluploadImage, data: formData).then((value) async {
        String urlPathImage =
            '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/$nameFile';
        // print('urlPathImage = ${MyUrlpath().urlpath}$urlPathImage');

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // String id_user = preferences.getString('Id_User');

        String urlInsertData =
            '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Register.php?isAdd=true&Image_Profile=$urlPathImage&Username=$username&Email=$email&Password=$password&Status=$chooseType';
        //Nameshop, Detailshop, Idcardshop;

        try {
          Response response = await Dio().get(urlInsertData);
          print('res = $response');

          if (response.toString() == 'true') {
            Fluttertoast.showToast(
                msg: "เพิ่มข้อมูลสำเร็จ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            RegisterFirebase();
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => LoginPage()));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
          } else {
            normalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลองใหม่ คะ');
          }
        } catch (e) {}
      });
    } catch (e) {}
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<Null> checkUser() async {
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/CheckUser.php?isAdd=true&Username=$username';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        uploadDataUser();
      } else {
        normalDialog(context,
            'User นี่ $username มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยน User ใหม่');
      }
    } catch (e) {}
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if (username == null ||
            username.isEmpty ||
            email == null ||
            email.isEmpty ||
            password == null ||
            password.isEmpty ||
            passwordcon == null ||
            passwordcon.isEmpty) {
          print('Have Space');
          normalDialog(context, 'มีช่องว่าง คะ กรุณากรอกทุกช่อง คะ');
        } else if (chooseType == null) {
          normalDialog(context, 'โปรด เลือกชนิดของผู้สมัคร');
        } else if (password.length < 6) {
          normalDialog(context, 'โปรดใส่หัสผ่าน 6 ตัวขึ้นไป');
        } else if (imageFile == null) {
          print('image = null' + '${imageFile}');
          imageFile = File(
              '/data/user/0/thealphamerc.flutter_login_signup/cache/image_picker5998432444005115913.jpg');
          checkUser();
        } else if (password != passwordcon) {
          normalDialog(context, 'รหัสผ่านไม่ตรงกัน');
        } else {
          checkUser();
          // print(imageFile);
        }
        // uploadDataUser(); //เชื่อมไปหน้าหลักของแอป //
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
            color: Colors.orange[400]),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage())); //เชื่อมไปหน้า Login //
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'มีบัญชีอยู่แล้วกรุณา ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldUsername("Username"),
        _entryFieldEmail("Email id"),
        _entryFieldPassword("Password (6 ตัวขึ้นไป)"),
        _entryFieldPasswordcon("ConfirmPassword"),

        // _entryField("Phone number"),
      ],
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
  //               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
  //         ],
  //       ),
  //     ),
  //   );
  // }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /// Firebase ///////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<Null> RegisterFirebase() async {
    await Firebase.initializeApp().then((value) async {
      // print('*** เชื่อมต่อ Firebase สำเร็จ *** user ==> $username, password ==> $password');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('สร้างบัญชีสำเร็จ');
        await value.user
            .updateProfile(displayName: username)
            .then((value2) async {
          String uid = value.user.uid;
          print('เพิ่มข้อมูลสำเร็จ = $uid');

          UserModelFB modelFB = UserModelFB(
              username: username,
              email: email,
              status: chooseType,
              password: password);
          // Map<String, dynamic> data = modelFB.toMap();

          await _AdddatatoFirebase.add({
            "username": modelFB.username,
            "email": modelFB.email,
            "password": modelFB.password,
            "status": modelFB.status,
          });

          // await FirebaseFirestore.instance
          //     .collection('user')
          //     .doc(uid)
          //     .set(data)
          //     .then((value) => print('เพิ่มข้อมูลลงใน Fire Store สำเร็จ'));
        });
      }).catchError((onError) => normalDialog(context, onError.message));
    });
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
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
            // Positioned(
            //   child: BackgroundLogin(), ////// พื้นหลัง ////////
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(height: height * .2),
                    SizedBox(
                      height: 20,
                    ),
                    _title(),
                    SizedBox(
                      height: 40,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    userType(),
                    shopType(),
                    SizedBox(
                      height: 10,
                    ),
                    _submitButton(),
                    // SizedBox(height: height * .10),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            // Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
