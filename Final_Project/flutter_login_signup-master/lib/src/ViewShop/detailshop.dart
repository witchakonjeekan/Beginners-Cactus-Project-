import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';

class detailshop extends StatefulWidget {
  final ShopModel getshopString;
  detailshop({Key key, this.getshopString}) : super(key: key);

  @override
  _detailshopState createState() => _detailshopState();
}

class _detailshopState extends State<detailshop> {
  ShopModel getshopStringtwo;
  String nameshop;
  String image;
  String detailshop;
  String chat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getshopStringtwo = widget.getshopString;
    // readData();
    nameshop = getshopStringtwo.nameShop;
    detailshop = getshopStringtwo.detail;
    image = getshopStringtwo.imageShop;
    chat = getshopStringtwo.username;
  }

  @override
  // Future<Null> readData() async {
  //   String shop_id = getshopStringtwo.shopId;
  //   String url =
  //       '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/showshopwhereshopid.php?isAdd=true&Shop_id=$shop_id';
  //   await Dio().get(url).then((value) {
  //     if (value.toString() != 'null') {
  //       var result = json.decode(value.data);
  //       for (var map in result) {
  //         ShopModel show = ShopModel.fromJson(map);
  //         setState(() {
  //           nameshop = show.nameShop;
  //           image = show.imageShop;
  //           detailshop = show.detail;
  //           chat = show.username;
  //         });
  //       }
  //     }
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดร้านค้า'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG10.jpg"),
            fit: BoxFit.cover,
          ),
        ),
//

        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ชื่อร้าน : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$nameshop',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 300.0,
                    height: 300.0,
                    child: Image.network('${MyUrlpath().urlpath}$image')),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'รายละเอียด : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                          child: Text(
                        '$detailshop',
                        style: TextStyle(fontSize: 20),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ติดต่อสอบถาม(Chat) : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$chat',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
