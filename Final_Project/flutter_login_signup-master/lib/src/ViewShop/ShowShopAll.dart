import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/ChatApp/Chatroom.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/Model/faverisModel.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/ViewShop/Spemain.dart';
import 'package:flutter_login_signup/src/ViewShop/showDetailShop.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ShopShow extends StatefulWidget {
  @override
  _ShopShowState createState() => _ShopShowState();
}

class _ShopShowState extends State<ShopShow> {
  List<ShopModel> GetdataShop = List();
  List<Widget> shopCard = List();
  bool loadpage = false;
  String usertouser;
  String token;

  //FaveritUser
  // bool check = false;
  var i = 0;
  List<String> setdata = List();
  List<FaveritModel> Getdatashow = List();

  @override
  void initState() {
    super.initState();
    Showshop();
    CheckUser();
  }

  Future<Null> Showshop() async {
    if (shopCard.length != 0) {
      shopCard.clear();
    }
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/getShopData.php?isAdd=true&Status=Shop';
    await Dio().get(url).then((value) {
      setState(() {
        loadpage = true;
      });
      if (value.toString() != 'null') {
        // print('value = $value');
        var result = json.decode(value.data);
        // print('result = $result');
        int index = 0;
        int indexdel = 0;
        bool check = false;
        // var i = 0;
        for (var map in result) {
          ShopModel datashop = ShopModel.fromJson(map);
          // print('Nameshop = ${datashop.nameShop}');
          // test(datashop);
          setdata.sort();
          if (i < setdata.length) {
            if (setdata[i] == datashop.shopId) {
              check = true;
              indexdel = i;
              // print(indexdel);
              print(i);
              i++;
              // i = 0;
            } else {
              check = false;
            }
          } else {
            check = false;
            // i = setdata.length;
            // i = 0;
          }
          setState(() {
            // test(datashop);
            GetdataShop.add(datashop);
            shopCard.add(showpageshop(datashop, index, indexdel, check));
            index++;
          });
        }
      } else {
        loadpage = false;
      }
    });
  }

  // Test
  Future<Null> Showshopfa() async {
    if (setdata.length != 0) {
      setdata.clear();
    }

    String url2 =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/faveritshop/getdatashop.php?isAdd=true&ID_User=$usertouser';
    await Dio().get(url2).then((value) {
      if (value.toString() != 'null') {
        // print('value = $value');
        var result = json.decode(value.data);
        // print('result = $result');

        for (var map in result) {
          FaveritModel showshopfa = FaveritModel.fromJson(map);
          setState(() {
            setdata.sort();
            setdata.add(showshopfa.iDShop);
            // setdata.sort(); //list
            Getdatashow.add(showshopfa);
          });

          // shopCard.add(showpageshop(datashop, index));

        }
      }
    });
  }
  //

  Future<Null> setidshop(ShopModel datashop) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ID', datashop.iD);
  }

  Future<Null> CheckUser() async {
    SharedPreferences preferencescheck = await SharedPreferences.getInstance();
    usertouser = preferencescheck.getString('Id_User');
    token = preferencescheck.getString('Token');
    print('Token : $token');
    // setState(() {
    Showshopfa();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ร้านค้าทั้งหมด"),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ShopShow()),
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
      body: shopCard.length == 0 && loadpage == false
          ?  MyStyle().showProgress()
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/login_BG06.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: GridView.extent(
                maxCrossAxisExtent: 250.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 5.0,
                children: shopCard,
              ),
            ),
    );
  }


  Widget showpageshop(ShopModel datashop, int index, int indexdel, bool check) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          // print('คุณคลิก index ที่ $index');
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => SelectSpeMain(
              detailshopcactus: GetdataShop[index],
            ),
          );
          Navigator.push(context, route);
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 72),
                    child: IconButton(
                      tooltip: 'แชท',
                      icon: Icon(
                        Icons.chat,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        if (usertouser != datashop.iD) {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => ChatroomPage(
                              chatname: datashop.username,
                            ),
                          );
                          Navigator.push(context, route);
                          print(datashop.username);
                        } else {
                          normalDialog(context, 'ไม่สามารถคุยกับตนเองได้');
                        }
                      },
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(right: 400),
                    // margin: EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: check == true
                          ? Icon(
                              Icons.notifications_active,
                              color: Colors.orange,
                            )
                          : Icon(
                              Icons.notifications,
                              color: Colors.grey,
                            ),
                      onPressed: () {
                        // int index2 = setdata[index];
                        check == true
                            ? deletefaverit(Getdatashow[indexdel])
                            : usertouser == datashop.iD
                                ? normalDialog(
                                    context, 'ไม่สามารถกดติดตามตนเองได้')
                                : adddatafaverit(datashop);
                      },
                    ),
                  )
                  // check == true
                  //     ? Container(
                  //         // margin: EdgeInsets.only(right: 400),
                  //         // margin: EdgeInsets.all(5.0),
                  //         child: IconButton(
                  //           icon: Icon(
                  //             Icons.notifications_active,
                  //             color: Colors.orange,
                  //           ),
                  //           onPressed: () {
                  //             // int index2 = setdata[index];
                  //             deletefaverit(Getdatashow[indexdel]);
                  //           },
                  //         ),
                  //       )
                  //     : Container(
                  //         // margin: EdgeInsets.all(5.0),
                  //         child: IconButton(
                  //           icon: Icon(
                  //             Icons.notifications,
                  //             color: Colors.grey,
                  //           ),
                  //           onPressed: () {
                  //             if (usertouser == datashop.iD) {
                  //               normalDialog(
                  //                   context, 'ไม่สามารถกดติดตามตนเองได้');
                  //             } else {
                  //               adddatafaverit(datashop);
                  //             }
                  //           },
                  //         ),
                  //       ),
                ],
              ),
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      ('${'${MyUrlpath().urlpath}'}${datashop.imageShop}')),
                ),
                // child: Image.network('${'${MyUrlpath().urlpath}'}${datashop.imageShop}'),
              ),
              SizedBox(
                height: 5,
              ),
              Text('ร้าน : ${datashop.nameShop}'),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // test(ShopModel datashop, int indexdel, int i) {
  //   setdata.sort();

  //   if (i < setdata.length) {
  //     if (setdata[i] == datashop.shopId) {
  //       check = true;
  //       indexdel = i;
  //       i++;
  //       // i = 0;
  //     } else {
  //       check = false;
  //     }
  //   } else {
  //     check = false;
  //   }
  // }

  Future<Null> adddatafaverit(ShopModel datashop) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle()
            .showTitleH2('คุณต้องการติดตามร้านค้า :  ${datashop.nameShop} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  // Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ShopShow()));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ShopShow()),
                      (route) => false);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/faveritshop/adddatafaverit.php?isAdd=true&ID_User=$usertouser&Name_Shop=${datashop.nameShop}&ID_Shop=${datashop.shopId}&Token_User=$token';
                  await Dio().get(url).then((value) => Showshop());
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

  // Widget setcolor(ShopModel datashop) {
  //   if (datashop.shopId == setdata) {
  //     int index = setdata.indexOf(null);
  //     Container(
  //       margin: EdgeInsets.only(right: 150),
  //       child: IconButton(
  //         icon: Icon(
  //           Icons.favorite,
  //           color: Colors.red,
  //         ),
  //         onPressed: () {
  //           deletefaverit(Getdatashow[index]);
  //         },
  //       ),
  //     );
  //   } else {
  //     Container(
  //       margin: EdgeInsets.only(right: 150),
  //       child: IconButton(
  //         icon: Icon(
  //           Icons.favorite,
  //           color: Colors.grey,
  //         ),
  //         onPressed: () {
  //           if (usertouser == datashop.iD) {
  //             normalDialog(context, 'ไม่สามารถกดติดตามตนเองได้');
  //           } else {
  //             adddatafaverit(datashop);
  //           }
  //         },
  //       ),
  //     );
  //   }
  // }

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
                  // Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ShopShow()));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ShopShow()),
                      (route) => false);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/faveritshop/delfaverit.php?isAdd=true&ID=${Getdatashow.iD}';
                  await Dio().get(url).then((value) => Showshop());
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
