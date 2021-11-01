import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/ViewShop/Spemain.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDataModelSup extends StatefulWidget {
  final String value;
  final String cactussup;
  const ShowDataModelSup({Key key, this.value, this.cactussup})
      : super(key: key);

  @override
  _ShowDataModelSupState createState() => _ShowDataModelSupState();
}

class _ShowDataModelSupState extends State<ShowDataModelSup> {
  String value;
  String cactussup;
  List<CactusDetailModel> ProductlistString = List();

  void initState() {
    super.initState();
    value = widget.value;
    cactussup = widget.cactussup;
    ShowData();
  }

  Future<Null> ShowData() async {
    // id_shop = getshopString.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/SelectcuctusPageShow/selectsup.php?isAdd=true&Spe_main=$value&Spe_sup=$cactussup';
    var response = await Dio().get(url);
    // print('res ==>>>> $response');
    var result = await json.decode(response.data);
    // print('result ==>>>> $result');
    if (response.toString() != 'null') {
      for (var map in result) {
        CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
        setState(() {
          ProductlistString.add(Showmenulist);
        });
      }
    }
  }

  Container ShowDataImage(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      width: MediaQuery.of(context).size.width * 0.5 - 16.0,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: NetworkImage(
                ('${'${MyUrlpath().urlpath}'}${ProductlistString[index].imageCactus}')),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget gotoshop(int index) {
    return Container(
      child: IconButton(
        tooltip: 'ไปยังร้านค้า',
        icon: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.green,
        ),
        onPressed: () {
          print('Idshop ===> ' + '${ProductlistString[index].shopId}');
          // String idshop = ProductlistString[index].shopId;
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => SelectSpeMain(
              sendforsearch: ProductlistString[index],
            ),
          );
          Navigator.push(context, route);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$value : $cactussup'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences preferencescheck =
                      await SharedPreferences.getInstance();
                  String status = preferencescheck.getString('Status');
                  Widget widget;
                  if (status == 'UserNormal') {
                    widget = HomeScreen();
                  } else {
                    widget = HomeScreenShop();
                  }
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => widget,
                  );
                  Navigator.pushAndRemoveUntil(
                      context,
                      route,
                      (route) =>
                          false); // ถ้า login แล้วจะไม่สามารถกดกลับได้นอกจาก logout
                },
                child: Icon(Icons.home),
              )),
        ],
      ),
      body: ProductlistString.length == 0
          ? MyStyle().showProgress()
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/login_BG03.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                itemCount: ProductlistString.length,
                itemBuilder: (context, index) => Row(
                  children: <Widget>[
                    ShowDataImage(context, index),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.4,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'ร้าน : ${ProductlistString[index].shopname}',
                                    style: MyStyle().mainTitle,
                                  ),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                gotoshop(index),
                              ],
                            ),
                            Text(
                              'สายพันธุ์ย่อย : ' +
                                  ProductlistString[index].speSup,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'ราคา : ' + ProductlistString[index].price,
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                            0.5 -
                                        0.8,
                                    child: Flexible(
                                      child: Text(
                                        'รายละเอียด : ' +
                                            ProductlistString[index].detail,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
