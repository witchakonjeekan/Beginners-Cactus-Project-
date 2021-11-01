import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';

import 'package:http/http.dart' as http;

class showmenushop extends StatefulWidget {
  final ShopModel getshopString;
  showmenushop({Key key, this.getshopString}) : super(key: key);

  @override
  _showmenushopState createState() => _showmenushopState();
}

class _showmenushopState extends State<showmenushop> {
  String id_shop;
  ShopModel getshopString;
  List<CactusDetailModel> ProductlistString = List();

  @override
  void initState() {
    super.initState();
    getshopString = widget.getshopString;
    ShowProductShop();
  }

  Future<Null> ShowProductShop() async {
    id_shop = getshopString.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Show_menu_allshop.php?isAdd=true&Shop_id=$id_shop';
    var response = await Dio().get(url);
    // print('res ==>>>> $response');
    var result = await json.decode(response.data);
    // print('result ==>>>> $result');
    for (var map in result) {
      CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
      setState(() {
        ProductlistString.add(Showmenulist);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ร้าน : ${getshopString.nameShop}'),
      ),
      body: ProductlistString.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              itemCount: ProductlistString.length,
              itemBuilder: (context, index) => Row(
                children: <Widget>[
                  ShowProductImage(context, index),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ProductlistString[index].speMain,
                          style: MyStyle().mainTitle,
                        ),
                        Text(
                          'สายพันธุ์ย่อย : ' +
                              ProductlistString[index].speSup,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'ราคา : ' + ProductlistString[index].price,
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    0.8,
                                child: Text(
                                  'รายละเอียด : ' +
                                      ProductlistString[index].detail,
                                  style: TextStyle(fontSize: 16),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Container ShowProductImage(BuildContext context, int index) {
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
}
