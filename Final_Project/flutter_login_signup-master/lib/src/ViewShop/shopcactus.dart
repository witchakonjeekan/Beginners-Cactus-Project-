import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';

class SDC_Gymnocalycium extends StatefulWidget {
  final ShopModel getshopString;
  final String spemain;
  SDC_Gymnocalycium({Key key, this.getshopString, this.spemain})
      : super(key: key);

  @override
  _SDC_GymnocalyciumState createState() => _SDC_GymnocalyciumState();
}

class _SDC_GymnocalyciumState extends State<SDC_Gymnocalycium> {
  String spe_main;
  String id_shop;
  ShopModel getshopString;
  List<CactusDetailModel> ProductlistString = List();

  @override
  void initState() {
    super.initState();
    getshopString = widget.getshopString;
    spe_main = widget.spemain;
    ShowProductShop();
  }

  Future<Null> ShowProductShop() async {
    id_shop = getshopString.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/selectshowdetail.php?isAdd=true&Shop_id=$id_shop&Spe_main=$spe_main&Type_cactus=0';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
          setState(() {
            ProductlistString.add(Showmenulist);
          });
        }
      }
      // print('result ==>>>> $result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ร้าน : ${getshopString.nameShop}'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: ProductlistString.length == 0
          ? Center(child: Text('ไม่มีสายพันธ์ุนี้ในร้านค้า'))
          : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/login_BG10.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            child: ListView.builder(
                itemCount: ProductlistString.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
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
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'ราคา : ' + ProductlistString[index].price + ' บาท',
                                style: TextStyle(fontSize: 16) ,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                              0.5 -
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
                  );
                }),
          ),
    );
  }

  Container ShowProductImage(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      width: MediaQuery.of(context).size.width * 0.47 - 16.0,
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
