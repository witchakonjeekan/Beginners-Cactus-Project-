import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/AdminReport_Model.dart';
import 'package:flutter_login_signup/src/Model/faverisModel.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/UserAdmin/HomePadeAdmin.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<SendReportModel> Getdata = List();
  // List<Widget> showcase = List();
  bool status = true;

  @override
  void initState() {
    super.initState();
    Showreport();
  }

  Future<Null> Showreport() async {
    if (Getdata.length != 0) {
      Getdata.clear();
    }

    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getReporttoadmin.php?isAdd=true&report_send=on';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        // print('value = $value');
        var result = json.decode(value.data);
        // print('result = $result');
        // int index = 0;
        for (var map in result) {
          SendReportModel getreport = SendReportModel.fromJson(map);
          print('Shop_name = ${getreport.shopName}');
          setState(() {
            Getdata.add(getreport);
            // showcase.add(showpage(getreport, index));
            // index++;
          });
          // ShopModel datashop = ShopModel.fromJson(map);
          // print('Nameshop = ${datashop.nameShop}');
          // setState(() {
          //   GetdataShop.add(datashop);
          //   shopCard.add(showpageshop(datashop, index));
          //   index++;
          // });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  // Widget showpage(SendReportModel getreport, int index) {
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
  //           Flexible(child: Text(getreport.shopName),),
  //           SizedBox(
  //             height: 70,
  //             width: 200,
  //           ),
  //           IconButton(
  //             icon: Icon(
  //               Icons.delete,
  //               color: Colors.red,
  //             ),
  //             onPressed: () => deleteCactus(getreport),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Future<Null> FavoriteWithNotification() async {
  //   String urltoken =
  //       '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/getdataFavorite.php?isAdd=true&ID_Shop=$idshopfavorite';
  //   await Dio().get(urltoken).then((value) {
  //     if (value.toString() != 'null') {
  //       var result = json.decode(value.data);
  //       print('result ===> $result');
  //       for (var json in result) {
  //         SendReportModel favoritesModel = SendReportModel.fromJson(json);
  //         String tokenUser = favoritesModel.tokenUser;
  //         print('tokenUser ===> $tokenUser');

  //         String title = 'มีการเพิ่มสินค้าจากร้าน : $nameshopfavorite';
  //         String body =
  //             'คุณสามารถเข้าไปดูสินค้าใหม่ได้ คลิก!! ${mainspecies} สายพันธุ์ย่อย ${NameCactusSup}';

  //         String urlSendtoken =
  //             '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/apiNotification.php?isAdd=true&token=$tokenUser&title=$title&body=$body';

  //         SendNotificationToUserFavorite(urlSendtoken);
  //       }
  //     } else {
  //       print('Error');
  //     }
  //   });
  // }

  Future<Null> SendNotificationToUserFavorite(String urlSendtoken) async {
    await Dio().get(urlSendtoken).then((value) =>
        print('เพิ่มข้อมูลการเพิ่มสินค้าไปให้ User ที่ติดตามแต่ละคน'));
  }

  Future<Null> deleteCactus(SendReportModel getreport) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2(
            'คุณต้องการปลดล็อคร้านค้า :  ${getreport.shopName} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/delshopreport.php?isAdd=true&ID=${getreport.iD}';
                  await Dio().get(url).then((value) => Showreport());

                  String title =
                      'ร้านค้า : ${getreport.shopName} ได้รับการปลดล็อคแล้ว ';
                  String body =
                      'ได้รับการปลดล็อคแล้ว คุณสามารถเพิ่มสินค้าได้ตามปกติ';

              

                  String urlSendtoken =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/apiNotification.php?isAdd=true&token=${getreport.token}&title=$title&body=$body';

                  SendNotificationToUserFavorite(urlSendtoken);
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
  //     children: showcase,
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ร้านค้าทั้งหมด"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ReportPage()),
                      (route) => false);
                },
                child: Icon(Icons.refresh_sharp),
              )),
              SizedBox(width: 10,),

              Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePageAdmin()),
                      (route) => false);
                },
                child: Icon(Icons.home),
              )),
          ],
        ),
        body: Getdata.length == 0?
            // MyStyle().showProgress()
            Center(
                child: Text('ไม่มีร้านค้าที่ถูกระงับ'),
              )
            : Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: Getdata.length,
                  itemBuilder:(context,index) =>GestureDetector(
                  child: Card(
                  child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   width: 125,
            //   height:
            //       125, // child: Image.network('${'${MyUrlpath().urlpath}'}${datashop.imageShop}'),
            // ),
            Flexible(child: Text(Getdata[index].shopName),),
            SizedBox(
              height: 70,
              width: 200,
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => deleteCactus(Getdata[index]),
            ),
          ],
        ),
      ),
    ))
              ],
            )
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
