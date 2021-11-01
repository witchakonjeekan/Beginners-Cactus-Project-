import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login_signup/src/Widget/backgroudlogre.dart';

//DataBase
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

//Image
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUpNormalAll extends StatefulWidget {
  SignUpNormalAll({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpNormalAllState createState() => _SignUpNormalAllState();
}

class _SignUpNormalAllState extends State<SignUpNormalAll> {
  String chooseType;
  File imageFile;
  final picker = ImagePicker();

  bool processing = false;
  bool signin = true;
  TextEditingController namectrl, emailctrl, passctrl;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = false;
      });
    } else
      setState(() {
        signin = true;
      });
  }

  void registerUser() async {
    setState(() {
      processing = true;
    });
    var uri = Uri.parse(
        "https://192.168.56.1/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/RegisterUser.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['Username'] = namectrl.text;
    request.fields['Password'] = passctrl.text;
    request.fields['Email'] = emailctrl.text;
    request.fields['Status'] = chooseType;
    var pic =
        await http.MultipartFile.fromPath("Image_Profile", imageFile.path);
    request.files.add(pic);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      print("Image Upload");
    } else {
      print("Image Not upload");
    }

    var data = json.decode(jsonEncode(res.body));
    // print(data);
    if (data == "'Error'") {
      Fluttertoast.showToast(
          msg: "เพิ่มไม่สำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "เพิ่มข้อมูลสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    setState(() {
      processing = false;
    });
  }

// Session
  // Future Session() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('Username', namectrl.text);
  //   // preferences.setString('Status', data);
  //   preferences.setString('Status', chooseType);
  

  //   // int counter = (preferences.getInt('counter') ?? 0) + 1;
  //   // print('Pressed $counter times.');
  //   // await preferences.setInt('counter', counter);
  // }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

// ช่องกรอกข้อมูล ////////////////////////////////////////////////////////////////////////////////

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
            controller: namectrl, //connectDB
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

/////////////////////////////////////////////////////////////////////////////////////////////////// ช่องกรอกข้อมูล ////////////////////////////////////////////////////////////////////////////////
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
            controller: emailctrl, //connectDB
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

/////////////////////////////////////////////////////////////////////////////////////////////////// ช่องกรอกข้อมูล ////////////////////////////////////////////////////////////////////////////////
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
            controller: passctrl, //connectDB
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

///////////////////////////////////////////////////////
  Widget _submitButton() {
    return InkWell(
      onTap: () {
        registerUser(); //เชื่อมไปหน้าหลักของแอป //
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
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

// ชื่อแอป///////////////////////////////////////////////////
  Widget _title() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: imageFile == null
                ? AssetImage('img/01_logo.png')
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
                color: Colors.teal,
                size: 28.0,
              ),
            ),
          )
        ],
      ),
    );
  }

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

  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    setState(() {
      imageFile = pickedFile;
    });
  }

///////////////////////////////////////////////////////////////

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldUsername("Username"),
        _entryFieldEmail("Email id"),
        _entryFieldPassword("Password"),

        // _entryField("Phone number"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: BackgroundLogin(), ////// พื้นหลัง ////////
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
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
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
