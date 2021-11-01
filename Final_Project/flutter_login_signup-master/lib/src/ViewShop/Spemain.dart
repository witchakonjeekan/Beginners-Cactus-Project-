import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/ChatApp/Chatroom.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/Model/faverisModel.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/ViewShop/detailshop.dart';
import 'package:flutter_login_signup/src/ViewShop/shopcactus.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectSpeMain extends StatefulWidget {
  final ShopModel detailshopcactus;
  final CactusDetailModel sendforsearch;
  SelectSpeMain({Key key, this.detailshopcactus, this.sendforsearch})
      : super(key: key);

  @override
  _SelectSpeMainState createState() => _SelectSpeMainState();
}

class _SelectSpeMainState extends State<SelectSpeMain> {
  ShopModel detailshopcactus;
  FaveritModel favermodel;
  CactusDetailModel sendforsearch;
  // String id_shop;
  List astro = List();
  List gym = List();
  List cory = List();
  List lop = List();
  List mam = List();
  List other02 = List();
  List<Widget> checkuser = List();
  String userid;
  bool checkout;
  String user, shop, tokenout;

  @override
  void initState() {
    super.initState();
    sendforsearch = widget.sendforsearch;
    detailshopcactus = widget.detailshopcactus;
    if (detailshopcactus == null) {
      CheckUser();
    } else {
      Astro();
      Gymno();
      Lop();
      Cory();
      Mam();
      checkfaver();
    }
  }

  Future<Null> CheckUser() async {
    if (detailshopcactus == null) {
      String shopidswap = sendforsearch.shopId;
      String url =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/SelectcuctusPageShow/swapmodel.php?isAdd=true&Shop_id=$shopidswap';
      await Dio().get(url).then((value) {
        if (value.toString() != 'null') {
          var result = json.decode(value.data);
          for (var map in result) {
            ShopModel shopswap = ShopModel.fromJson(map);
            detailshopcactus = shopswap;
            Astro();
            Gymno();
            Lop();
            Cory();
            Mam();
            checkfaver();
          }
        }
      });
    }
  }

  Future<Null> checkfaver() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString('Id_User');
    String token = preferences.getString('Token');
    String shopid = detailshopcactus.shopId;
    bool check = true;
    String urlcheck =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/faveritshop/userandshop.php?isAdd=true&ID_User=$userid&ID_Shop=$shopid';
    await Dio().get(urlcheck).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          FaveritModel showshopfa = FaveritModel.fromJson(map);
          favermodel = showshopfa;
          check = true;
          checkout = check;
          user = userid;
          shop = shopid;
          tokenout = token;
          // faver(check, userid, shopid, token);
          print('${favermodel}');
          print(
              'check:${checkout} , User : ${user} , shop : ${shop} , token : ${token}');
          // checkuser.add(faver(check, userid, shopid, token));

          // shopCard.add(showpageshop(datashop, index));
        }
        ;
        // favermodel =
        // bool check = true;
        // faver(check,userid,shopid);

      } else {
        check = false;
        checkout = check;
        user = userid;
        shop = shopid;
        tokenout = token;
        // faver(check, userid, shopid, token);
        print(
            'check:${checkout} , User : ${user} , shop : ${shop} , token : ${token}');
      }
    });
  }

  Padding notifi(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: faver(),
    );
  }

  Widget faver() {
    return checkout == true
        ? Container(
            // margin: EdgeInsets.only(right: 400),
            // margin: EdgeInsets.all(5.0),
            child: IconButton(
              icon: Icon(
                Icons.notifications_active,
                color: Colors.orange,
              ),
              onPressed: () {
                // int index2 = setdata[index];
                deletefaverit(favermodel);
              },
            ),
          )
        : Container(
            // margin: EdgeInsets.all(5.0),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.grey,
              ),
              onPressed: () {
                if (user == detailshopcactus.iD) {
                  normalDialog(context, 'ไม่สามารถกดติดตามตนเองได้');
                } else {
                  adddatafaverit(user, shop, tokenout);
                }
              },
            ),
          );
  }

  Future<Null> adddatafaverit(
      String userid, String shopid, String token) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2(
            'คุณต้องการติดตามร้านค้า :  ${detailshopcactus.nameShop} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ShopShow()));
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => SelectSpeMain()),
                  //     (route) => false);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/faveritshop/adddatafaverit.php?isAdd=true&ID_User=$userid&Name_Shop=${detailshopcactus.nameShop}&ID_Shop=${detailshopcactus.shopId}&Token_User=$token';
                  await Dio().get(url).then((value) => CheckUser());
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

  Future<Null> deletefaverit(FaveritModel favermodel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2(
            'คุณต้องการยกเลิกติดตามร้านค้า :  ${favermodel.nameShop} ??'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ShopShow()));
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => SelectSpeMain()),
                  //     (route) => false);
                  String url =
                      '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/faveritshop/delfaverit.php?isAdd=true&ID=${favermodel.iD}';
                  await Dio().get(url).then((value) => CheckUser());
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

  Widget detail() {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => detailshop(
            getshopString: detailshopcactus,
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.blue[400],
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.blue[800]),
        child: Text(
          'รายละเอียดร้านค้า',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  Widget Astrophytum() {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SDC_Gymnocalycium(
            getshopString: detailshopcactus,
            spemain: 'Astrophytum'.trim(),
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.orange[700]),
        child: Text(
          'Astrophytum' + '  (${astro.length})',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

//////////
  ///
  Future<Null> Astro() async {
    String id_shop = detailshopcactus.shopId;
    // id_shop = getshopString.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/selectshowdetail.php?isAdd=true&Shop_id=$id_shop&Spe_main=Astrophytum';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
          setState(() {
            astro.add(Showmenulist.speMain);
          });
        }
      }
      // print('result ==>>>> $result');
    });
  }

  Future<Null> Gymno() async {
    // id_shop = getshopString.shopId;
    String id_shop = detailshopcactus.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/selectshowdetail.php?isAdd=true&Shop_id=$id_shop&Spe_main=Gymnocalycium';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
          setState(() {
            gym.add(Showmenulist.speMain);
          });
        }
      }
      // print('result ==>>>> $result');
    });
  }

  Future<Null> Lop() async {
    // id_shop = getshopString.shopId;
    String id_shop = detailshopcactus.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/selectshowdetail.php?isAdd=true&Shop_id=$id_shop&Spe_main=Lophophora';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
          setState(() {
            lop.add(Showmenulist.speMain);
          });
        }
      }
      // print('result ==>>>> $result');
    });
  }

  Future<Null> Cory() async {
    String id_shop = detailshopcactus.shopId;
    // id_shop = getshopString.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/selectshowdetail.php?isAdd=true&Shop_id=$id_shop&Spe_main=Coryphantha';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
          setState(() {
            cory.add(Showmenulist.speMain);
          });
        }
      }
      // print('result ==>>>> $result');
    });
  }

  Future<Null> Mam() async {
    String id_shop = detailshopcactus.shopId;
    // id_shop = getshopString.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/selectshowdetail.php?isAdd=true&Shop_id=$id_shop&Spe_main=Mammillaria';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
          setState(() {
            mam.add(Showmenulist.speMain);
          });
        }
      }
      // print('result ==>>>> $result');
    });
  }

  Future<Null> othernum() async {
    String id_shop = detailshopcactus.shopId;
    // id_shop = getshopString.shopId;
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/selectshowdetail.php?isAdd=true&Shop_id=$id_shop&Spe_main=Othercactus';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          CactusDetailModel Showmenulist = CactusDetailModel.fromJson(map);
          setState(() {
            other02.add(Showmenulist.speMain);
          });
        }
      }
      // print('result ==>>>> $result');
    });
  }

  ///
//////////

  Widget Coryphantha() {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SDC_Gymnocalycium(
            getshopString: detailshopcactus,
            spemain: 'Coryphantha'.trim(),
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.orange[700]),
        child: Text(
          'Coryphantha' + '  (${cory.length})',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  Widget Gymnocalycium() {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SDC_Gymnocalycium(
            getshopString: detailshopcactus,
            spemain: 'Gymnocalycium'.trim(),
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.orange[700]),
        child: Text(
          'Gymnocalycium' + '  (${gym.length})',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  Widget Lophophora() {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SDC_Gymnocalycium(
            getshopString: detailshopcactus,
            spemain: 'Lophophora'.trim(),
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.orange[700]),
        child: Text(
          'Lophophora' + '  (${lop.length})',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  Widget Mammillaria() {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SDC_Gymnocalycium(
            getshopString: detailshopcactus,
            spemain: 'Mammillaria'.trim(),
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.orange[700]),
        child: Text(
          'Mammillaria' + '  (${mam.length})',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  Widget other() {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SDC_Gymnocalycium(
            getshopString: detailshopcactus,
            spemain: 'Othercactus'.trim(),
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.blue[400],
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.blue[800]),
        child: Text(
          'Cactus สายพันธุ์อื่นๆ' + '  (${other02.length})',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'ร้าน ${detailshopcactus == null ? sendforsearch.shopname : detailshopcactus.nameShop}'),
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          actions: <Widget>[
            notifi(context),
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    if (userid != detailshopcactus.iD) {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => ChatroomPage(
                          chatname: detailshopcactus.username,
                        ),
                      );
                      Navigator.push(context, route);
                      // print(datashop.username);
                    } else {
                      normalDialog(context, 'ไม่สามารถคุยกับตนเองได้');
                    }
                  },
                  child: Icon(Icons.chat,
                        color: Colors.green),
                )),
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
          ]),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG08.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              detail(),
              SizedBox(
                height: 15,
              ),
              Astrophytum(),
              SizedBox(
                height: 15,
              ),
              Coryphantha(),
              SizedBox(
                height: 15,
              ),
              Gymnocalycium(),
              SizedBox(
                height: 15,
              ),
              Lophophora(),
              SizedBox(
                height: 15,
              ),
              Mammillaria(),
              SizedBox(
                height: 15,
              ),
              other(),
              SizedBox(
                height: 130,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
