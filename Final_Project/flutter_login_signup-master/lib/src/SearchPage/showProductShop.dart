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

class showProductShop extends StatefulWidget {

  final String value;
  const showProductShop({Key key, this.value}) : super(key: key);

  @override
  _showProductShopState createState() => _showProductShopState();
}

class _showProductShopState extends State<showProductShop> {

  String value;
  List<CactusDetailModel> ProductlistString = List();

  void initState() {
    super.initState();
    value = widget.value;
    ShowData();
  }

  Future<Null> ShowData() async {
    // id_shop = getshopString.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/SelectcuctusPageShow/selectspe.php?isAdd=true&Spe_main=$value';
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
        icon: Icon(
          Icons.shop,
          color: Colors.green,
        ),
        onPressed: () {
          print('Idshop ===> ' + '${ProductlistString[index].shopId}');
          // String idshop = ProductlistString[index].shopId;
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => SelectSpeMain(
              // senddatatoshop: ProductlistString[index],
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
        title: Text('???????????????????????? : $value'),
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
                          false); // ????????? login ?????????????????????????????????????????????????????????????????????????????????????????? logout
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  '???????????? : ${ProductlistString[index].shopname}',
                                  style: MyStyle().mainTitle,
                                ),
                              ),
                              gotoshop(index),
                            ],
                          ),
                          Text(
                            '??????????????????????????????????????? : ' +
                                ProductlistString[index].speSup,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '???????????? : ' + ProductlistString[index].price,
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          0.8,
                                  child: Flexible(
                                    child: Text(
                                      '?????????????????????????????? : ' +
                                          ProductlistString[index].detail,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
