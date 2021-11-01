import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
// import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/AddDataCactus.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/EditCactus.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageCheckCactus extends StatefulWidget {
  @override
  _PageCheckCactusState createState() => _PageCheckCactusState();
}

class _PageCheckCactusState extends State<PageCheckCactus> {
  bool loadStatus = true; //โหลดไม่เสร็จ Json
  bool status = true; //มีข้อมูล
  List<CactusDetailModel> cactusall = List();
  

  @override
  void initState() {
    super.initState();
    readDataCatus();
  }

  Future<Null> readDataCatus() async {
    if (cactusall.length != 0) {
      cactusall.clear();
    }

    String idshop = await sharedPrefer();
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getCactuswhereShop.php?isAdd=true&Shop_id=$idshop';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          CactusDetailModel cactus = CactusDetailModel.fromJson(map);
          setState(() {
            cactusall.add(cactus);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  Future<String> sharedPrefer() async {
    SharedPreferences preferencesshop = await SharedPreferences.getInstance();
    String idshop = preferencesshop.getString('Shop_id');
    print('$idshop');
    return idshop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Cactus ทั้งหมด'),
        centerTitle: true,
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
            loadStatus ? MyStyle().showProgress() : ShowDataCactusCheck(),
            addDataCactusPage(),
          ],
        ),
      ),
    );
  }

  Future<Null> checkbanuser() async {
    String idshop = await sharedPrefer();
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/CheckReport.php?isAdd=true&Shop_id=$idshop';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        print(response);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => AddandEditCactus());
        Navigator.push(context, route).then((value) => readDataCatus());
      } else {
        normalDialog(
            context, 'การเพิ่มข้อมูลถูกระงับกรุณารอฝ่ายแอดมินทำการแก้ไข');
      }
    } catch (e) {}
  }

  Widget addDataCactusPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  checkbanuser();
                },
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget ShowDataCactusCheck() {
    return status
        ? ShowDetailAll()
        : Center(
            child: Text('ไม่มีCactusกรุณาทำการเพิ่มร้านค้า'),
          );
  }

  Widget ShowDetailAll() => ListView.builder(
      itemCount: cactusall.length,
      itemBuilder: (context, index) => Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Image.network(
                  '${'${MyUrlpath().urlpath}'}${cactusall[index].imageCactus}',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text('สายพันธุ์หลัก :  ' + cactusall[index].speMain),
                      Text('สายพันธุ์ย่อย : ' + cactusall[index].speSup),
                      Text('รายละเอียด : ' + cactusall[index].detail),
                      Text('ราคา : ' + cactusall[index].price + ' บาท'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (context) => EditCactusData(
                                  cactusModel: cactusall[index],
                                ),
                              );
                              Navigator.push(context, route)
                                  .then((value) => readDataCatus());
                            },
                          ),




                          IconButton(
                            icon: cactusall[index].typeCactus == '0' ? Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.green[900] 
                            ) : Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey[900] 
                            ) ,

                            onPressed: () => cactusall[index].typeCactus == '0' ? unvisible(cactusall[index]) : visible(cactusall[index]) 
                            // onPressed: () => ,
                          ),




                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => deleteCactus(cactusall[index]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));

          
  Future<Null> deleteCactus(CactusDetailModel cactus) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2(
            'คุณต้องการลบ Cactus ${cactus.speSup} จาก ${cactus.speMain} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/DelCactus.php?isAdd=true&Manager_id=${cactus.managerId}';
                  await Dio().get(url).then((value) => readDataCatus());
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

  Future<Null>visible(CactusDetailModel cactus)async{  //มองเห็น
      showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2(
            'คุณเปิดการมองเห็น ${cactus.speSup} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/visible/visible.php?isAdd=true&Manager_id=${cactus.managerId}&Type_cactus=0';
                  await Dio().get(url).then((value) => readDataCatus());
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

    Future<Null>unvisible(CactusDetailModel cactus)async{  //มองไม่เห็น
      showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2(
            'คุณปิดการมองเห็น ${cactus.speSup} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/visible/visible.php?isAdd=true&Manager_id=${cactus.managerId}&Type_cactus=1';
                  await Dio().get(url).then((value) => readDataCatus());
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
}
