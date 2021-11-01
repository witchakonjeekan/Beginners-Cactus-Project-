import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/Model/faverisModel.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/ViewShop/Spemain.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:shared_preferences/shared_preferences.dart';

class favoritShop extends StatefulWidget {
  // const favoritShop({ Key? key }) : super(key: key);

  @override
  _favoritShopState createState() => _favoritShopState();
}

class _favoritShopState extends State<favoritShop> {
  @override
  void initState() {
    super.initState();
    Showshopfa();
  }

  List<FaveritModel> Getdatashow = List();
  // List<Widget> shopshow = List();

  @override
  Future<Null> Showshopfa() async {
    if (Getdatashow.length != 0) {
      Getdatashow.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String iduser = preferences.getString('Id_User');

    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/faveritshop/getdatashop.php?isAdd=true&ID_User=$iduser';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        // print('value = $value');
        var result = json.decode(value.data);
        // print('result = $result');
        for (var map in result) {
          FaveritModel showshopfa = FaveritModel.fromJson(map);
          print('Nameshop = ${showshopfa.nameShop}');
          setState(() {
            Getdatashow.add(showshopfa);
            // shopCard.add(showpageshop(datashop, index));
          });
        }
      } else {
        // status = false;
      }
    });
  }

  Future<Null> deletefaverit(FaveritModel Getdatashow) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2(
            'คุณต้องการยกเลิกติดตามร้านค้า :  ${Getdatashow.nameShop} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/faveritshop/delfaverit.php?isAdd=true&ID=${Getdatashow.iD}';
                  await Dio().get(url).then((value) => Showshopfa());
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ร้านค้าที่ท่านติดตาม'),
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => favoritShop()),
                        (route) => false);
                  },
                  child: Icon(Icons.refresh_sharp),
                )),
            SizedBox(width: 5),
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences preferencesstatus =
                        await SharedPreferences.getInstance();
                    String status = preferencesstatus.getString('Status');
                    Widget widget;
                    if (status == 'UserNormal') {
                      widget = HomeScreen();
                    } else {
                      widget = HomeScreenShop();
                    }
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => widget,
                    );
                    Navigator.pushAndRemoveUntil(context, route,
                        (route) => false); // ถ้า login แล้วจะไม่สามารถ
                  },
                  child: Icon(Icons.home),
                )),
          ],
        ),
        body: Getdatashow.length == 0
            ? Center(
                child: Text('ไม่มีร้านค้าที่คุณติดตาม'),
              )
            : Container(
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/login_BG05.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    ListView.builder(
                        itemCount: Getdatashow.length,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                String idshopgotopage =
                                    Getdatashow[index].iDShop;
                                ShopModel shoppage;
                                String url =
                                    '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/SelectcuctusPageShow/swapmodel.php?isAdd=true&Shop_id=$idshopgotopage';
                                await Dio().get(url).then((value) {
                                  if (value.toString() != 'null') {
                                    var result = json.decode(value.data);
                                    for (var map in result) {
                                      ShopModel newpage =
                                          ShopModel.fromJson(map);
                                      setState(() {
                                        shoppage = newpage;
                                      });
                                    }
                                  }
                                });
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => SelectSpeMain(
                                    detailshopcactus: shoppage,
                                  ),
                                );
                                Navigator.push(context, route);
                              },
                              child: Card(
                                color: Colors.blue[100],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      // margin: EdgeInsets.only(right: 180),

                                      child: Text(
                                        'ร้าน : ${Getdatashow[index].nameShop}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ),
                                        onPressed: () =>
                                            deletefaverit(Getdatashow[index]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ],
                ),
              ));
  }
}
