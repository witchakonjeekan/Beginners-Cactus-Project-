import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/User_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDataUserAll extends StatefulWidget {
  final UserModel useredit;
  EditDataUserAll({Key key, this.useredit}) : super(key: key);

  //   final CactusDetailModel cactusModel;
  // EditCactusData({Key key, this.cactusModel}) : super(key: key);

  @override
  _EditDataUserAllState createState() => _EditDataUserAllState();
}

class _EditDataUserAllState extends State<EditDataUserAll> {
  File file;
  UserModel usereditpage;
  String username, password, pathimage;

  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    usereditpage = widget.useredit;
    username = usereditpage.username;
    password = usereditpage.password;
    pathimage = usereditpage.imageProfile;
    // username = username
    // password = cactusModel.detail;
    // pathimage = cactusModel.imageCactus;
    // loadModel();
  }

  @override
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
                    '${'${MyUrlpath().urlpath}'}${usereditpage.imageProfile}',
                    fit: BoxFit.cover,
                  )
                : Image.file(file),
          ),
          IconButton(
              onPressed: () => chooseImage(ImageSource.gallery),
              icon: Icon(Icons.add_photo_alternate))
        ],
      );

  FloatingActionButton uploadEdit() {
    return FloatingActionButton(
      onPressed: () {
        if (username.isEmpty || password.isEmpty) {
          normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
        } else {
          // confirmEdit();
          checkUser();
        }
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> checkUser() async {
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/CheckUser.php?isAdd=true&Username=$username';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(value.toString());
        for (var map in result) {
          UserModel usercheckname = UserModel.fromJson(map);
          if (usercheckname.username == username && usercheckname.iDUser == usereditpage.iDUser ) {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: MyStyle().showTitleH2(
                    'คุณยังไม่ได้เปลี่ยนแปลงชื่อผู้ใช้ต้องการกดบันทึก ??'),
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
                'User นี้ $username มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยน User ใหม่');
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

  Future<Null> editDataUpMySQL() async {
    String urluploadImage =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/UploadimageUser.php';
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'PageCactus$i.jpg';
    String urlPathImage;
    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urluploadImage, data: formData).then((value) async {
        urlPathImage =
            '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/$nameFile';
        // print('urlPathImage = ${'${MyUrlpath().urlpath}'}$urlPathImage');
        return urlPathImage;
      });
    } catch (e) {}
    String id = usereditpage.iDUser;
    String urlsetshop;
    String url;
    if (file == null) {
      url =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/EditDataUser.php?isAdd=true&ID_User=$id&Username=$username&Password=$password&Image_Profile=$pathimage';
      await Dio().get(url).then((value) {
        if (value.toString() == 'true') {
          normalDialogEditUser(context, 'แก้ไขข้อมูลสำเร็จแล้ว');
          // print('$urlPathImage');
          print(value);
        } else {
          normalDialog(context, 'ผิดพลาดกรุณาลองใหม่อีกคร้ง');
        }
      });
      urlsetshop =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/setusername.php?isAdd=true&ID=$id&Username=$username';
      await Dio().get(urlsetshop);
    } else {
      url =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/EditDataUser.php?isAdd=true&ID_User=$id&Username=$username&Password=$password&Image_Profile=$urlPathImage';
      await Dio().get(url).then((value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
          normalDialogEditUser(context, 'แก้ไขข้อมูลสำเร็จแล้ว');
          // print('$pathimage');

        } else {
          normalDialog(context, 'ผิดพลาดกรุณาลองใหม่อีกคร้ง');
        }
      });
      urlsetshop =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/setusername.php?isAdd=true&ID=$id&Username=$username';
      await Dio().get(urlsetshop);
    }

    // String url =
    //     '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/EditDataCactus.php?isAdd=true&Manager_id=$id&Spe_sup=$nameSup&Detail=$detail&Price=$price&Image_cactus=$urlPathImage';
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxWidth: 800.0, maxHeight: 800.0);
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget usernamepage() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => username = value.trim(),
              initialValue: username,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget passwordpage() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => password = value.trim(),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              initialValue: password,
              decoration: InputDecoration(
                labelText: 'Password',
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

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: uploadEdit(),
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล ${usereditpage.username}'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            usernamepage(),
            SizedBox(
              height: 10,
            ),
            groupimage(),
            passwordpage(),
            // priceCactus(),
          ],
        ),
      ),
    );
  }
}
