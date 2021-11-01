import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/AddDataCactus.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/AddShop.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/EditShop.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/PageCheckCactus.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageCheckShops extends StatefulWidget {
  @override
  _PageCheckShopsState createState() => _PageCheckShopsState();
}

class _PageCheckShopsState extends State<PageCheckShops> {
  bool loadStatus = true; //โหลดไม่เสร็จ Json
  bool status = true; //มีข้อมูล

  List<ShopModel> shopall = List();

  ShopModel shopsolo;
  String nameshop, imageshop, detailshop;

  @override
  void initState() {
    super.initState();
    readDataShop();
  }

  Future<Null> readDataShop() async {
    if (shopall.length != 0) {
      shopall.clear();
    }

    SharedPreferences preferencesuser = await SharedPreferences.getInstance();
    String iduser = preferencesuser.getString('Id_User');

    print('$iduser');
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getShopwhereUser.php?isAdd=true&ID=$iduser';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          ShopModel shop = ShopModel.fromJson(map);
          shopsolo = shop;
          nameshop = shopsolo.nameShop;
          imageshop = shopsolo.imageShop;
          detailshop = shopsolo.detail;
          setShopid(shop);

          // setState(() {
          //   shopall.add(shop);
          // });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('ร้านค้าของคุณ !!'),
        centerTitle: true,
        // centerTitle: true,
      ),
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG07.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Stack(
          children: <Widget>[
            loadStatus ? MyStyle().showProgress() : ShowDataShopCheck(),
          ],
        ),
      ),
    );
  }

  Widget addDataShopPage() {
    return Container(
      // mainAxisAlignment: MainAxisAlignment.start,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            children: [
              Center(
                child: Text('ท่านยังไม่มีร้านค้ากรุณาเพิ่มร้านค้าก่อนใช้งาน'),
              ),
            ],
          ),
          SizedBox(
            height: 275,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => AddandEditShop());
                    Navigator.push(context, route)
                        .then((value) => readDataShop());
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget ShowDataShopCheck() {
    return status ? Showshopdetail() : addDataShopPage();
    // Center(
    //     child: Text('ไม่มีCactusกรุณาทำการเพิ่มร้านค้า'),
    //   );
  }

  Widget Showshopdetail() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Center(
                child: Text(
              'ชื่อร้าน :  ' + nameshop,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            )),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10.0),
              width: 300,
              height: 300,
              child: Image.network(
                '${'${MyUrlpath().urlpath}'}${imageshop}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20,),
            Column(
              children: <Widget>[
                Text(
                  'รายละเอียด : ' + detailshop,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => EditShopData(
                            shopModel: shopsolo,
                          ),
                        );
                        Navigator.push(context, route)
                            .then((value) => readDataShop());
                      },
                      icon: Icon(Icons.settings, size: 25),
                      label: Text("แก้ไขข้อมูลร้านค้า",style: TextStyle(fontSize: 18),),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageCheckCactus()));
                      },
                      icon: Icon(Icons.new_label_sharp, size: 25),
                      label: Text("จัดการรายการสินค้า Cactus",style: TextStyle(fontSize: 18),),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> setShopid(ShopModel shopModel) async {
    SharedPreferences preferencesshop = await SharedPreferences.getInstance();
    preferencesshop.setString('Shop_id', shopModel.shopId);
    preferencesshop.setString('Name_shop', shopModel.nameShop);
  }

  // Future<Null> deletShop(ShopModel shop) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => SimpleDialog(
  //       title: MyStyle().showTitleH2(
  //           'คุณต้องการลบ Cactus ${cactus.speSup} จาก ${cactus.speMain} ??'),
  //       children: <Widget>[
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: <Widget>[
  //             FlatButton(
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //                 String url =
  //                     '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/DelCactus.php?isAdd=true&Manager_id=${cactus.managerId}';
  //                 await Dio().get(url).then((value) => readDataCatus());
  //               },
  //               child: Text('ยืนยัน'),
  //             ),
  //             FlatButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text('ยกเลิก'),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
