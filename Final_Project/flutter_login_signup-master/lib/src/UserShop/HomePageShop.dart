import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/ChatApp/Chatroom.dart';
import 'package:flutter_login_signup/src/EditDataUser.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/Model/User_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/SearchPage/SelectSearch.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/CheckShopTrue.dart';
import 'package:flutter_login_signup/src/ViewShop/ShowShopAll.dart';
import 'package:flutter_login_signup/src/ViewShop/menuselectshop.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/backgroudlogre.dart';
import 'package:flutter_login_signup/src/SearchPage/SearchPage.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenShop extends StatefulWidget {
  @override
  _HomeScreenShopState createState() => _HomeScreenShopState();
}

class _HomeScreenShopState extends State<HomeScreenShop> {
  String nameUser;
  String statusUser;
  String profileimage;
  String host;
  String iduser;

  UserModel getuser;
  String username, password, image, checkshop;

  // List<UserModel> getuser = List();
  List<Widget> usershow = List();

  @override
  void initState() {
    super.initState();
    readData();
    aboutNotification();
  }

  // Future<Null> findUser() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     nameUser = preferences.getString('Username');
  //     statusUser = preferences.getString('Status');
  //     profileimage = preferences.getString('Image_Profile');
  //   });
  //   host = '${MyUrlpath().urlpath}$profileimage';
  // }

  Future<Null> readData() async {
    // if (shopall.length != 0) {
    //   shopall.clear();
    // }

    await prefer();

    print('$iduser');
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getimageshowhome.php?isAdd=true&ID_User=$iduser';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);

        for (var map in result) {
          UserModel userindex = UserModel.fromJson(map);
          setState(() {
            getuser = userindex;
            username = getuser.username;
            password = getuser.password;
            image = getuser.imageProfile;
            host = '${MyUrlpath().urlpath}$image';
          });
        }
      }
    });

    // String urlcheckshop =
    // '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getShopwhereUser.php?isAdd=true&ID=$iduser';
    // await Dio().get(urlcheckshop).then((value) {
    //   if (value.toString() != 'null') {
    //     var result = json.decode(value.data);
    //     for (var map in result) {
    //       ShopModel shop = ShopModel.fromJson(map);
    //       setState(() {
    //         checkshop = shop.status;
    //       });
    //     }
    //   }
    // });
  }

  Future<void> prefer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    statusUser = preferences.getString('Status');
    iduser = preferences.getString('Id_User');
  }

  Future<Null> SingoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Fluttertoast.showToast(
        msg: "Logout Shop Succes",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => LoginPage()));

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
    // ล้าง Acccout ที่เข้ามาให้หมด// เมื่อทำการล้าง Acccout แล้วจะทำการปิดแอปพลิเคชั่น
  }

  Future<Null> checkstatus() async {
    String checkshopstatus;
    String urlcheckshop =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getShopwhereUser.php?isAdd=true&ID=$iduser';
    await Dio().get(urlcheckshop).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          ShopModel shop = ShopModel.fromJson(map);
          setState(() {
            checkshopstatus = shop.status;
          });
        }
      }
    });
     if (checkshopstatus == 'Shop') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PageCheckShops()));
    } else {
      normalDialog(context, 'ร้านค้าของท่านถูกระงับจากพฤติกรรมที่ไม่เหมาะสม');
    }
  }

  Future<Null> aboutNotification() async {
    if (Platform.isAndroid) {
      print('aboutNitification Android');

      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      await firebaseMessaging.configure(
        onLaunch: (message) async {
          print('onLaunch ==> สถานะปิดโปรแกรม');
        },
        onResume: (message) async {
          print('onResume ==> สถานะเปิดมือถือ/ปิดมือถือ');
        },
        onMessage: (message) async {
          print('onMessage ==> สถานะเปิดโปรแกรม');
          String title = message['notification']['title'];
          String notiMessage = message['notification']['body'];
          normalDialog2(context, title, notiMessage);
        },
      );
    } else {}
  }

  Future<Null> editclear() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => EditDataUserAll(
        useredit: getuser,
      ),
    );
    Navigator.push(context, route).then((value) => readData());
    // ล้าง Acccout ที่เข้ามาให้หมด// เมื่อทำการล้าง Acccout แล้วจะทำการปิดแอปพลิเคชั่น
  }

  @override
  Widget build(BuildContext context) {
// to get size กำหนด size
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            // Positioned(child: BackgroundLogin()),
            //สร้างหน้าที่ไม่ชนกับขอบบนโทรศัพท์
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(bottom: 20),

                      //สร้าง Row
                      child: detailuser(),
                    ),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        primary: false,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            elevation: 4,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuAllSearch())),
                              child: Image.asset(
                                'img/01_logoname01.png', //ไปหน้าค้นหา
                                width: 200, height: 200,
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            elevation: 4,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectPageShop())),
                              child: Image.asset(
                                'img/02_logoname.png', //ร้านค้า
                                width: 200, height: 200,
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            elevation: 4,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatroomPage())),
                              child: Image.asset(
                                'img/05_chatname.png', // chat
                                width: 200,
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            elevation: 4,
                            child: InkWell(
                              onTap: () => checkstatus()
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => PageCheckShops()))
                              ,
                              child: Image.asset(
                                'img/setshop01name.png', //setting shop
                                width: 200,
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            elevation: 4,
                            child: InkWell(
                              onTap: () => SingoutUser(),
                              child: Image.asset(
                                'img/031_logoname.png', //logout
                                width: 200,
                              ),
                            ),
                          ),

                          /////
                          ///
                          // Card(
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(7)),
                          //   elevation: 4,
                          //   child: InkWell(
                          //     onTap: () => Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => favoritShop())),
                          //     child: Image.asset(
                          //       'img/setshop01.png', //setting shop
                          //       width: 200,
                          //     ),
                          //   ),
                          // ),

                          ///
                          ///
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailuser() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage('$host'),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$username' == null ? 'Error' : 'สวัสดี : $username',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              'สถานะ  : $statusUser',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )
          ],
        ),
        Center(
          child: IconButton(
            tooltip: 'ตั้งค่าผู้ใช้',
            icon: Icon(
              Icons.settings,
              color: Colors.grey[850],
            ),
            onPressed: () {
              editclear();
            },
          ),
        ),
      ],
    );
  }
}
