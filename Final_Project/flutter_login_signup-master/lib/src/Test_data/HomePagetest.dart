import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/User_Model.dart';
import 'package:flutter_login_signup/src/SearchPage/SelectSearch.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/CheckShopTrue.dart';
import 'package:flutter_login_signup/src/ViewShop/ShowShopAll.dart';
import 'package:flutter_login_signup/src/Widget/backgroudlogre.dart';
import 'package:flutter_login_signup/src/SearchPage/SearchPage.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenShop1 extends StatefulWidget {
  @override
  _HomeScreenShop1State createState() => _HomeScreenShop1State();
}

class _HomeScreenShop1State extends State<HomeScreenShop1> {
  String nameUser;
  String statusUser;
  String profileimage;
  String iduser;
  String host;
  String status;

  List<UserModel> getuser = List();
  @override
  void initState() {
    super.initState();
    readData();
  }

  // Future<Null> findUser() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     nameUser = preferences.getString('Username');
  //     statusUser = preferences.getString('Status');
  //     profileimage = preferences.getString('Image_Profile');
  //   });
  //   host = 'http://192.168.56.1$profileimage';
  // }

  Future<Null> readData() async {
    // if (shopall.length != 0) {
    //   shopall.clear();
    // }

    await prefer();

    print('$iduser');
    String url =
        'http://192.168.56.1/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getimageshowhome.php?isAdd=true&ID_User=$iduser';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          UserModel userindex = UserModel.fromJson(map);
          setState(() {
            getuser.add(userindex);
          });
        }
      }
    });
  }

  Future<void> prefer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    nameUser = preferences.getString('Username');
    statusUser = preferences.getString('Status');
    profileimage = preferences.getString('Image_Profile');
    iduser = preferences.getString('Id_User');
    host = 'http://192.168.56.1$profileimage';
  }

  Widget ShowDetailAll() => ListView.builder(
      itemCount: getuser.length,
      itemBuilder: (context, index) => Row(
            children: <Widget>[
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(
                    '${'http://192.168.56.1'}${getuser[index].imageProfile}'),
              ),
              // Container(
              //   padding: EdgeInsets.all(10.0),
              //   width: MediaQuery.of(context).size.width * 0.5,
              //   height: MediaQuery.of(context).size.width * 0.4,
              //   child: Image.network(
              //     '${'http://192.168.56.1'}${getuser[index].imageProfile}',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text('ชื่อ :  ' + getuser[index].username),
                      Text('สถานะ : ' + getuser[index].status),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              // MaterialPageRoute route = MaterialPageRoute(
                              //   builder: (context) => EditShopData(
                              //     shopModel: shopall[index],
                              //   ),
                              // );
                              // Navigator.push(context, route)
                              //     .then((value) => readDataShop());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
  // SizedBox(height: 20,),
  Widget ShowManu() => GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        primary: false,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            elevation: 4,
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuAllSearch())),
              child: Image.asset(
                'img/01_logo.png', //ไปหน้าค้นหา
                width: 200, height: 200,
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            elevation: 4,
            child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ShopShow())),
              child: Image.asset(
                'img/02_logo.png', //ร้านค้า
                width: 200, height: 200,
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            elevation: 4,
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PageCheckShops())),
              child: Image.asset(
                'img/04_logo.png', // chat
                width: 200,
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            elevation: 4,
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PageCheckShops())),
              child: Image.asset(
                'img/setshop01.png', //setting shop
                width: 200,
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            elevation: 4,
            child: InkWell(
              onTap: () => SingoutUser(),
              child: Image.asset(
                'img/031_logo.png', //logout
                width: 200,
              ),
            ),
          ),
        ],
      );

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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    // ล้าง Acccout ที่เข้ามาให้หมด// เมื่อทำการล้าง Acccout แล้วจะทำการปิดแอปพลิเคชั่น
  }

  @override
  Widget build(BuildContext context) {
// to get size กำหนด size
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(child: BackgroundLogin()),
            ShowDetailAll(),
            SizedBox(
              height: 10,
            ),
            // ShowManu(),
          ],
        ),
      ),
    );
  }
}
