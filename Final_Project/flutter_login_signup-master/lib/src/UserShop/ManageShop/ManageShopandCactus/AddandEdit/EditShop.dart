import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:image_picker/image_picker.dart';

class EditShopData extends StatefulWidget {
  final ShopModel shopModel;
  EditShopData({Key key, this.shopModel}) : super(key: key);

  @override
  _EditShopDataState createState() => _EditShopDataState();
}

class _EditShopDataState extends State<EditShopData> {
  ShopModel shopModel;
  File file;
  String detail, shopname, pathimage;

  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    shopModel = widget.shopModel;
    shopname = shopModel.nameShop;
    detail = shopModel.detail;
    pathimage = shopModel.imageShop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: uploadEdit(),
      appBar: AppBar(
        title: Text('แก้ไขร้านค้า ${shopModel.nameShop}'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              shopnames(),
              SizedBox(
                height: 20,
              ),
              groupimage(),
              SizedBox(
                height: 20,
              ),
              detailShop(),
              // priceCactus(),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton uploadEdit() {
    return FloatingActionButton(
      onPressed: () {
        if (shopname.isEmpty || detail.isEmpty) {
          normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
        } else {
          checkname();
        }
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> checkname() async {
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/CheckShop.php?isAdd=true&Name_Shop=$shopname';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(value.toString());
        for (var map in result) {
          ShopModel usercheckname = ShopModel.fromJson(map);
          if (usercheckname.nameShop == shopname &&
              usercheckname.shopId == shopModel.shopId) {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: MyStyle().showTitleH2(
                    'คุณยังไม่ได้เปลี่ยนแปลงชื่อร้านค้าต้องการกดบันทึก ??'),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          confirmEdit();
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
          } else {
            normalDialog(context,
                'ชื่อร้าน $shopname มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยนชื่อร้านใหม่');
          }
        }
      } else {
        confirmEdit();
      }
    });
    // try {
    //   Response response = await Dio().get(url);
    //   if (response.toString() == 'null') {
    //     confirmEdit();
    //   } else {
    //     normalDialog(context,
    //         'User นี่ $username มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยน User ใหม่');
    //   }
    // } catch (e) {}
  }

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการเปลี่ยนแปลงข้อมูลใช่หรือไม่ ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    editDataUpMySQL();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  label: Text('ใช่')),
              FlatButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  label: Text('ยกเลิก')),
            ],
          )
        ],
      ),
    );
  }

  // Future<Null> uploadImageCactus() async {
  //   String urluploadImage =
  //       '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/UplordimageCactus.php';
  //   Random random = Random();
  //   int i = random.nextInt(1000000);
  //   String nameFile = 'PageShop$i.jpg';
  //   try {
  //     Map<String, dynamic> map = Map();
  //     map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
  //     FormData formData = FormData.fromMap(map);

  //     await Dio().post(urluploadImage, data: formData).then((value) async {
  //       String urlPathImage =
  //           '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/$nameFile';
  //       print('urlPathImage = ${'${MyUrlpath().urlpath}'}$urlPathImage');
  //       return urlPathImage;
  //     });
  //   } catch (e) {}
  // }

  Future<Null> editDataUpMySQL() async {
    String urluploadImage =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/UplordimageShop.php';
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'PageShop$i.jpg';
    String urlPathImage;
    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urluploadImage, data: formData).then((value) async {
        urlPathImage =
            '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageShopDetail/$nameFile';
        print('urlPathImage = ${'${MyUrlpath().urlpath}'}$urlPathImage');
        return urlPathImage;
      });
    } catch (e) {}
    String id = shopModel.shopId;
    String url;
    String urlsetname;

    if (file == null) {
      url =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/EditDataShop.php?isAdd=true&Shop_id=$id&Name_shop=$shopname&Detail=$detail&Image_shop=$pathimage';
      await Dio().get(url).then((value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
          print('$urlPathImage');
        } else {
          normalDialog(context, 'ผิดพลาดกรุณาลองใหม่อีกคร้ง');
        }
      });
      urlsetname =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/setUsernameShop.php?isAdd=true&Shop_id=$id&Shopname=$shopname';
      await Dio().get(urlsetname);
    } else {
      url =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/EditDataShop.php?isAdd=true&Shop_id=$id&Name_shop=$shopname&Detail=$detail&Image_shop=$urlPathImage';
      await Dio().get(url).then((value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
          print('$pathimage');
        } else {
          normalDialog(context, 'ผิดพลาดกรุณาลองใหม่อีกคร้ง');
        }
      });
      urlsetname =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/setUsernameShop.php?isAdd=true&ID=$id&Shopname=$shopname';
      await Dio().get(urlsetname);
    }
  }

  Widget groupimage() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () => chooseImage(ImageSource.camera),
            icon: Icon(Icons.add_a_photo),
          ),
          Container(
            width: 250.0,
            height: 250.0,
            child: file == null
                ? Image.network(
                    '${'${MyUrlpath().urlpath}'}${shopModel.imageShop}',
                    fit: BoxFit.cover,
                  )
                : Image.file(file),
          ),
          IconButton(
              onPressed: () => chooseImage(ImageSource.gallery),
              icon: Icon(Icons.add_photo_alternate))
        ],
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxWidth: 800.0, maxHeight: 800.0);
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget shopnames() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => shopname = value.trim(),
              initialValue: shopname,
              decoration: InputDecoration(
                labelText: 'ชื่อร้านค้า',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget detailShop() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => detail = value.trim(),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              initialValue: detail,
              decoration: InputDecoration(
                labelText: 'รายละเอียด',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  // Widget priceCactus() => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //           margin: EdgeInsets.only(top: 16.0),
  //           width: 250.0,
  //           child: TextFormField(
  //             onChanged: (value) => price = value.trim(),
  //             initialValue: price,
  //             decoration: InputDecoration(
  //               labelText: 'ราคา',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
}
