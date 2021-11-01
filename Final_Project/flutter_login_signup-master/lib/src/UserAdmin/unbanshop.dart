import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/AdminReport_Model.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/Model/User_Model.dart';
import 'package:flutter_login_signup/src/Model/faverisModel.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/UserAdmin/HomePadeAdmin.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnBanPage extends StatefulWidget {
  @override
  _UnBanPageState createState() => _UnBanPageState();
}

class _UnBanPageState extends State<UnBanPage> {
  List<ShopModel> Getdata = List();
  // List<Widget> showshop = List();
  bool status = true;

  @override
  void initState() {
    super.initState();
    ShowshopAll();
  }

  Future<Null> ShowshopAll() async {
    if (Getdata.length != 0) {
      Getdata.clear();
    }
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getShopData.php?isAdd=true&Status=Banshop';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        // print('value = $value');
        var result = json.decode(value.data);
        // int index = 0;
        // print('result = $result');
        for (var map in result) {
          ShopModel datashop = ShopModel.fromJson(map);
          setState(() {
            Getdata.add(datashop);
            // showshop.add(showpage(datashop, index));
            // index++;
          });
        }
      } else {
        status = false;
      }
    });
  }

  // Widget showpage(ShopModel getban, int index) {
  //   return GestureDetector(
  //     child: Card(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           // Container(
  //           //   width: 125,
  //           //   height:
  //           //       125, // child: Image.network('${'${MyUrlpath().urlpath}'}${datashop.imageShop}'),
  //           // ),
  //           Flexible(
  //             child: Text(getban.nameShop),
  //           ),
  //           SizedBox(
  //             height: 70,
  //             width: 200,
  //           ),
  //           IconButton(
  //             icon: Icon(
  //               Icons.delete_forever,
  //               color: Colors.red,
  //             ),
  //             onPressed: () => banshopCactus(getban),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<Null> SendNotificationToUserFavorite(String urlSendtoken) async {
    await Dio().get(urlSendtoken).then((value) => print('เพิ่มข้อมูล'));
  }

  Future<Null> unbanshopCactus(ShopModel getban) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle()
            .showTitleH2('คุณต้องการปลดระงับร้านค้า :  ${getban.nameShop} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String token;
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/adminsetting/banshop.php?isAdd=true&Shop_id=${getban.shopId}&Status=Shop';
                  await Dio().get(url).then((value) => ShowshopAll());

                  String title = 'ร้านค้า : ${getban.nameShop} ถูกปลดระงับแล้ว ';
                  String body =
                      'ร้านค้าของท่านได้รับการปลดระงับจาก Admin';

                  String urlgettoken =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/adminsetting/gettoken.php?isAdd=true&ID_User=${getban.iD}';
                  await Dio().get(urlgettoken).then((value) {
                    if (value.toString() != 'null') {
                      var result = json.decode(value.data);
                      for (var map in result) {
                        UserModel usertoken = UserModel.fromJson(map);
                        setState(() {
                          token = usertoken.token;
                          String urlSendtoken =
                              '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/apiNotification.php?isAdd=true&token=${token}&title=$title&body=$body';
                          print(token);
                          SendNotificationToUserFavorite(urlSendtoken);
                          // showshop.add(showpage(datashop, index));
                        });
                      }
                    }
                  });

                  // String urlSendtoken =
                  //     '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/apiNotification.php?isAdd=true&token=${token}&title=$title&body=$body';

                  // SendNotificationToUserFavorite(urlSendtoken);
                },
                child: Text('ยืนยัน'),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget ShowDataCactusCheck() {
  //   return status
  //       ? ShowDetailAll()
  //       : Center(
  //           child: Text('ไม่มีCactusกรุณาทำการเพิ่มร้านค้า'),
  //         );
  // }

  // Widget Show() {
  //   return ListView(
  //     padding: const EdgeInsets.all(8),
  //     children: showshop,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ร้านค้าทั้งหมดที่โดนระงับ"),
      ),
      body: Getdata.length == 0
          ? Center(
              child: Text('ไม่มีร้านค้าที่ถูกระงับ'),
            )
          : Stack(
              children: <Widget>[
                ListView.builder(
                    itemCount: Getdata.length,
                    itemBuilder: (context, index) => GestureDetector(
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // Container(
                                //   width: 125,
                                //   height:
                                //       125, // child: Image.network('${'${MyUrlpath().urlpath}'}${datashop.imageShop}'),
                                // ),
                                Flexible(
                                  child: Text(Getdata[index].nameShop),
                                ),
                                SizedBox(
                                  height: 70,
                                  width: 200,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      unbanshopCactus(Getdata[index]),
                                ),
                              ],
                            ),
                          ),
                        ))
              ],
            ),

      // Show()

      // GridView.extent(
      //     maxCrossAxisExtent: 500.0,
      //     mainAxisSpacing: 10.0,
      //     crossAxisSpacing: 5.0,
      //     children: showcase,
      //   ),
    );
  }
}
