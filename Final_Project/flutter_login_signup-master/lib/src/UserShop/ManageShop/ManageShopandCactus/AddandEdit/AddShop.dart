import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nextflow_thai_personal_id/nextflow_thai_personal_id.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddandEditShop extends StatefulWidget {
  const AddandEditShop({Key key}) : super(key: key);

  @override
  _ManagementShopPageState createState() => _ManagementShopPageState();
}

class _ManagementShopPageState extends State<AddandEditShop> {
  File _image;
  final picker = ImagePicker();
  String Nameshop, Detailshop, Idcardshop;
  ThaiIdValidator thaivalidator =
      ThaiIdValidator(errorMessage: 'Incorrect, Please check again');

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  // TextEditingController nameshopController = TextEditingController();
  // TextEditingController detailshopController = TextEditingController();
  // TextEditingController idcardController = TextEditingController();

  Widget nameshopForm(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              onChanged: (value) => Nameshop = value.trim(),
              // controller: nameshopController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////////////

  Widget detailshopForm(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              onChanged: (value) => Detailshop = value.trim(),
              // controller: detailshopController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget idcardshopFrom(String title) {
    // ThaiIdValidator thaivalidator = ThaiIdValidator(errorMessage: 'Incorrect, Please check again');
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              maxLength: 13,
              validator: thaivalidator.validate,
              onChanged: (value) => Idcardshop = value.trim(),
              // controller: idcardController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget savedatabuttom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: Colors.green[700],
        onPressed: () {
          if (Nameshop == null ||
              Nameshop.isEmpty ||
              Detailshop == null ||
              Detailshop.isEmpty ||
              Idcardshop == null ||
              Idcardshop.isEmpty) {
            normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
          } else if (_image == null) {
            normalDialog(context, 'กรุณาเลือกรูปภาพ');
          } else if (thaivalidator.validate(Idcardshop) != null) {
            normalDialog(context, 'กรุณากรอกบัตรประชาชนให้ถูกต้อง');
          } else {
            checkname();
          }
          print(thaivalidator.validate(Idcardshop));
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'บันทึกข้อมูลร้านค้า',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> checkname() async {
    String url =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/CheckShop.php?isAdd=true&Name_Shop=$Nameshop';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        uploadDataShop();
      } else {
        normalDialog(context,
            'User นี่ $Nameshop มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยน User ใหม่');
      }
    } catch (e) {}
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<Null> uploadDataShop() async {
    String urluploadImage =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/UplordimageShop.php';

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'PageShop$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(_image.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urluploadImage, data: formData).then((value) async {
        String urlPathImage =
            '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageShopDetail/$nameFile';
        print('urlPathImage = ${'${MyUrlpath().urlpath}'}$urlPathImage');

        SharedPreferences preferences = await SharedPreferences.getInstance();
        String id_user = preferences.getString('Id_User');
        String username_shop = preferences.getString('Username');

        String urlInsertData =
            '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/AddShop.php?isAdd=true&Image_Shop=$urlPathImage&Name_Shop=$Nameshop&Detail=$Detailshop&ID_card=$Idcardshop&ID=$id_user&Username=$username_shop';
        //Nameshop, Detailshop, Idcardshop;
        await Dio()
            .get(urlInsertData)
            .then((value) => normalDialogpage(context, 'เพิ่มร้านค้าสำเร็จ'));
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('กรุณาเพิ่มร้านค้าก่อนใช้งาน'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG03.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              OutlineButton(
                onPressed: choiceImage,
                child: Text('กรุณาเลือกรูปภาพร้านค้า'),
              ),
              Container(
                width: 200,
                child: _image == null
                    ? Image.asset('img/img_logo.png')
                    : Image.file(_image),
              ),
              SizedBox(
                height: 10,
              ),
              nameshopForm('ชื่อร้านค้า'),
              SizedBox(
                height: 10,
              ),
              detailshopForm('รายละเอียดร้านค้า'),
              SizedBox(
                height: 10,
              ),
              idcardshopFrom('หมายเลขบัตรประชาชน 13 หลัก'),
              SizedBox(
                height: 20,
              ),
              savedatabuttom(),
            ],
          ),
        ),
      ),
    );
  }
}
