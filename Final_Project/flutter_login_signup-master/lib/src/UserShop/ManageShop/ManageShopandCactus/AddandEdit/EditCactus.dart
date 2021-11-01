import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Model/CactusDetail_Model.dart';
import 'package:flutter_login_signup/src/MyUrlPath.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class EditCactusData extends StatefulWidget {
  final CactusDetailModel cactusModel;
  EditCactusData({Key key, this.cactusModel}) : super(key: key);

  @override
  _EditCactusDataState createState() => _EditCactusDataState();
}

class _EditCactusDataState extends State<EditCactusData> {
  CactusDetailModel cactusModel;
  File file;
  String nameSup, detail, price, pathimage;

  //
  List _outputs;
  String valuelabel;
  bool _inProcess = false;

  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    cactusModel = widget.cactusModel;
    nameSup = cactusModel.speSup;
    detail = cactusModel.detail;
    price = cactusModel.price;
    pathimage = cactusModel.imageCactus;
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: uploadEdit(),
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล Cactus ${cactusModel.speSup}'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Container(
        
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              nameSupSpe(),
              SizedBox(
                height: 10,
              ),
              groupimage(),
              detailCactus(),
              priceCactus(),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton uploadEdit() {
    return FloatingActionButton(
      onPressed: () {
        if (nameSup.isEmpty || detail.isEmpty) {
          normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
        } else {
          confirmEdit();
        }
      },
      child: Icon(Icons.cloud_upload),
    );
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
                  SizedBox(),//
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

///////////////////////////////////////////////

  // settingImage() async {
  //   this.setState(() {
  //     _inProcess = true;
  //   });
  //   // File image = await ImagePicker.pickImage(source: source);
  //   if (file != null) {
  //     File cropped = await ImageCropper.cropImage(
  //         sourcePath: file.path,
  //         aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //         compressQuality: 100,
  //         maxWidth: 700,
  //         maxHeight: 700,
  //         compressFormat: ImageCompressFormat.jpg,
  //         androidUiSettings: AndroidUiSettings(
  //           toolbarColor: Colors.blue,
  //           toolbarTitle: "ปรับแต่งรูปภาพ",
  //           statusBarColor: Colors.deepOrange.shade900,
  //           backgroundColor: Colors.white,
  //         ));

  //     this.setState(() {
  //       file = cropped;
  //       _inProcess = false;
  //     });
  //   } else {

  //     this.setState(() {
  //       _inProcess = false;
  //     });
  //   }
  // }

///////////////////////////////////////////////
  pickImage() async {
    var image = await file;
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
    return valuelabel.trim();
  }
//////////////////////////////////////////////////////////
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
        '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/UplordimageCactus.php';
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
            '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/$nameFile';
        print('urlPathImage = ${'${MyUrlpath().urlpath}'}$urlPathImage');
        return urlPathImage;
      });
    } catch (e) {}
    String id = cactusModel.managerId;

    String url;
    if (file == null) {
      url =
          '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/EditDataCactus.php?isAdd=true&Manager_id=$id&Spe_sup=$nameSup&Detail=$detail&Price=$price&Image_cactus=$pathimage';
      await Dio().get(url).then((value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
          print('$urlPathImage');
        } else {
          normalDialog(context, 'ผิดพลาดกรุณาลองใหม่อีกคร้ง');
        }
      });
    } else if (file != null) {
      if (valuelabel == cactusModel.speMain) {
        url =
            '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/EditDataCactus.php?isAdd=true&Manager_id=$id&Spe_sup=$nameSup&Detail=$detail&Price=$price&Image_cactus=$urlPathImage';
        await Dio().get(url).then((value) {
          if (value.toString() == 'true') {
            // Navigator.pop(context);
            normalDialog(context, 'แก้ไขข้อมูลสำเร็จแล้ว');
            print('$pathimage');
          } else {
            normalDialog(context, 'ผิดพลาดกรุณาลองใหม่อีกคร้ง');
          }
        });
      } else {
        normalDialog(context,
            'รูปภาพใหม่ไม่ตรงกับสายพันธ์เดิม : ${cactusModel.speMain}');
      }
    }

    // String url =
    //     '${MyUrlpath().urlpath}/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/EditDataCactus.php?isAdd=true&Manager_id=$id&Spe_sup=$nameSup&Detail=$detail&Price=$price&Image_cactus=$urlPathImage';
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
                    '${'${MyUrlpath().urlpath}'}${cactusModel.imageCactus}',
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

  Widget nameSupSpe() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => nameSup = value.trim(),
              initialValue: nameSup,
              decoration: InputDecoration(
                labelText: 'ชื่อสายพันธุ์ย่อย',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget detailCactus() => Row(
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

  Widget priceCactus() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => price = value.trim(),
              initialValue: price,
              decoration: InputDecoration(
                labelText: 'ราคา',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
