import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/Model/Shop_Model.dart';
import 'package:flutter_login_signup/src/Model/faverisModel.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/PageCheckCactus.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite/tflite.dart';

class AddandEditCactus extends StatefulWidget {
  const AddandEditCactus({Key key}) : super(key: key);

  @override
  _AddandEditCactusState createState() => _AddandEditCactusState();
}

class _AddandEditCactusState extends State<AddandEditCactus> {
  File _image;
  final picker = ImagePicker();
  String NameCactusSup, Detail, price;

// Model มาใช้
  // String namecactusMain;
  List _outputs;
  String valuelabel;
  bool _inProcess = false;

  var count = 1;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
      pickImage();
    });
  }

  // Widget nameMainForm(String title) {
  //   //สายพันธุ์หลัก
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(
  //           title,
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextField(
  //             onChanged: (value) => NameCactusMain = value.trim(),
  //             // controller: nameshopController,
  //             decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 fillColor: Color(0xfff3f3f4),
  //                 filled: true))
  //       ],
  //     ),
  //   );
  // }
  Future<Null> FavoriteWithNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idshopfavorite = preferences.getString('Shop_id');
    String nameshopfavorite = preferences.getString('Name_shop');
    print('idshopfavorite ===> $idshopfavorite');

    String urltoken =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/getdataFavorite.php?isAdd=true&ID_Shop=$idshopfavorite';
    await Dio().get(urltoken).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result ===> $result');
        for (var json in result) {
          FaveritModel favoritesModel = FaveritModel.fromJson(json);
          String tokenUser = favoritesModel.tokenUser;
          print('tokenUser ===> $tokenUser');

          String title = 'มีการเพิ่มสินค้าจากร้าน : $nameshopfavorite';
          String body =
              'คุณสามารถเข้าไปดูสินค้าใหม่ได้ คลิก!! ${mainspecies} สายพันธุ์ย่อย ${NameCactusSup}';

          // MaterialPageRoute route = MaterialPageRoute(
          //   builder: (context) => send(
          //     shopsend: title,
          //     shopdetail: body,
          //   ),
          // );
          String urlSendtoken =
              '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Notification/apiNotification.php?isAdd=true&token=$tokenUser&title=$title&body=$body';

          SendNotificationToUserFavorite(urlSendtoken);
        }
      } else {
        print('ผู้ติดตาม ไม่มี');
      }
    });
  }

  Future<Null> SendNotificationToUserFavorite(String urlSendtoken) async {
    await Dio().get(urlSendtoken).then((value) =>
        print('เพิ่มข้อมูลการเพิ่มสินค้าไปให้ User ที่ติดตามแต่ละคน'));
  }

  String mainspecies = null;
  List<DropdownMenuItem<String>> _dropDownItemCactusB() {
    List<String> cactusb = [
      "Astrophytum",
      "Coryphantha",
      "Gymnocalycium",
      "Lophophora",
      "Mammillaria",
      "Othercactus"
      // "ไม่แน่ชัด"
    ];
    return cactusb
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  Widget nameMainForm() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton(
            hint: Text("เลือกสายพันธ์ุหลัก"),
            onChanged: (String newValue) {
              setState(() {
                mainspecies = newValue;
                print(mainspecies);
              });
            },
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
            value: mainspecies,
            items: _dropDownItemCactusB(),
          ),
        ),
      ),
    );
  }

  //   Widget nameSupForm(String title) {
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Container(
  //         padding: EdgeInsets.only(left: 16, right: 16),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.grey, width: 1),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         child: DropdownButton(
  //           hint: Text("เลือกสายพันธ์หลัก"),
  //           onChanged: (String newValue) {
  //             setState(() {
  //               mainspecies = newValue;
  //               print(mainspecies);
  //             });
  //           },
  //           dropdownColor: Colors.white,
  //           icon: Icon(Icons.arrow_drop_down),
  //           iconSize: 36,
  //           isExpanded: true,
  //           underline: SizedBox(),
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 22,
  //           ),
  //           value: mainspecies,
  //           items: _dropDownItemCactusB(),
  //         ),
  //       ),
  //     ),
  //   );
  // }
////////////////////////////////////////////////////////////////////////////////////////////

  Widget nameSupForm(String title) {
    //สายพันธุ์ย่อย
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              TextField(
                  onChanged: (value) => NameCactusSup = value.trim(),
                  // controller: nameshopController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true))
            ],
          ),
        ),
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////////////

  Widget detailForm(String title) {
    //รายละเอียด
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              TextField(
                  onChanged: (value) => Detail = value.trim(),
                  // controller: nameshopController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true))
            ],
          ),
        ),
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget PriceForm(String title) {
    //ราคา
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              TextField(
                  onChanged: (value) => price = value.trim(),
                  // controller: nameshopController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true))
            ],
          ),
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////

  pickImage() async {
    var image = await _image;
    setState(() {
      // _loading = true;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      // _loading = false;
      _outputs = output;
      print(_outputs);
      gotoPage(_outputs);
      // showDetailCactus(_outputs);
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "asset/model_unquant.tflite",
      labels: "asset/labels.txt",
    );
  }

  gotoPage(_output) {
    valuelabel = "${_outputs[0]["label"]}".replaceAll(RegExp(r'[0-9]'), '');
    // valuelabel = ("0");
    // print(value);
  }

  Future<Null> getprefer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String Shopid = preferences.getString('Shop_id');
    String Shopname = preferences.getString('Name_shop');
    String Token = preferences.getString('Token');

    // normalDialogpage(context, 'ถึงขีดจำกัดของข้อผิดพลาดกรุณารอแอดมินปลดล็อค');
    String urlInsertDataban =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/AddReport.php?isAdd=true&Shop_id=$Shopid&Shop_name=$Shopname&Token=$Token';
    await Dio().get(urlInsertDataban);
    normalDialogpage(context, 'ถึงขีดจำกัดของข้อผิดพลาดกรุณารอแอดมินปลดล็อค');
  }

//// แก้ไข
  Future<Null> checkimage() async {
    if (_image != null) {
      if (count <= 5) {
        if (mainspecies == valuelabel.trim()) {
          savedatabuttom();
          // choiceImage,
          count = 1;
        } else {
          normalDialog(context,
              'รูปภาพไม่ตรงกับสายพันธ์ที่เลือกไว้กรุณาลองใหม่ได้อีก : $count ครั้ง ไม่เกิน 5 ครั้ง : แนะนำ($valuelabel)');
          count++;
        }
        // count++;
      } else {
        getprefer();
      }
    } else {
      normalDialog(context, 'กรุณาเพิ่มรูปภาพ');
    }
  }

////////////////////////////////////////

  settingImage() async {
    this.setState(() {
      _inProcess = true;
    });
    // File image = await ImagePicker.pickImage(source: source);
    if (_image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: _image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blue,
            toolbarTitle: "ปรับแต่งรูปภาพ",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _image = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

////////////////////////////////////////
  Widget savedatabuttom() {
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    // child: RaisedButton.icon(
    //   onPressed: () {
    if (mainspecies == null ||
        mainspecies.isEmpty ||
        NameCactusSup == null ||
        NameCactusSup.isEmpty ||
        Detail == null ||
        Detail.isEmpty ||
        price == null ||
        price.isEmpty) {
      normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
    } else {
      uploadData();
      FavoriteWithNotification();
    }
    // },
    // icon: Icon(
    //   Icons.save,
    //   color: Colors.white,
    // ),
    // label: Text(
    //   'บันทึกข้อมูลร้านค้า',
    //   style: TextStyle(color: Colors.white),
    // ),
    //   ),
    // );
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<Null> uploadData() async {
    String urluploadImage =
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/UplordimageCactus.php';

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'PageCactus$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(_image.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urluploadImage, data: formData).then((value) async {
        String urlPathImage =
            '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/$nameFile';
        print('urlPathImage = ${'${MyUrlpath().urlpath}'}$urlPathImage');

        SharedPreferences preferencesshop =
            await SharedPreferences.getInstance();
        String id_shop = preferencesshop.getString('Shop_id');
        String Shopname = preferencesshop.getString('Name_shop');

        String urlInsertData =
            '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/AddCactus.php?isAdd=true&Image_cactus=$urlPathImage&Spe_main=$mainspecies&Spe_sup=$NameCactusSup&Detail=$Detail&Price=$price&Shop_id=$id_shop&Shopname=$Shopname';
        //Nameshop, Detailshop, Idcardshop;
        await Dio().get(urlInsertData).then((value) => Navigator.pop(context));
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การจัดCactus'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  OutlineButton(
                    onPressed: choiceImage,
                    child: Text('เลือกรูปภาพ'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  OutlineButton(
                    onPressed: () {
                      _image == null
                          ? normalDialog(context, 'กรุณาเพิ่มรูปภาพก่อน')
                          : settingImage();
                    },
                    child: Text('แก้ไขรูปภาพ'),
                  ),
                ],
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
              nameMainForm(),
              SizedBox(
                height: 10,
              ),
              nameSupForm('ชื่อสายพันธุ์ย่อย'),
              SizedBox(
                height: 10,
              ),
              detailForm('รายละเอียด'),
              SizedBox(
                height: 10,
              ),
              PriceForm('ราคา'),
              SizedBox(
                height: 20,
              ),
              // savedatabuttom(),
              RaisedButton.icon(
                color: Colors.green[800],
                onPressed: checkimage,
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(
                  'บันทึกข้อมูลร้านค้า',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
