import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/MLtest.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/test.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ModelPage extends StatefulWidget {
  @override
  _ModelPageState createState() => _ModelPageState();
}

// class ScreenArguments {
//   final File imageFile;

//   ScreenArguments(this.imageFile);
// }

class _ModelPageState extends State<ModelPage> {
  File imageFile;
  File test;
  bool _inProcess = false;

// เลือกชนิดของภาพ
  _openGallary(BuildContext context) async {
    var selectgallery =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = selectgallery;
      
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var selectcamera = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = selectcamera;
      test = selectcamera;
    });

    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Center(child: Text("เลือกประเภทของรูปภาพ")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  // GestureDetector(
                  //   child: Center(child: Text("คลังภาพ")),
                  //   onTap: () {
                  //     _openGallary(context);
                  //   },
                  // ),
                  ElevatedButton.icon(
                  onPressed: () {
                    _openGallary(context);
                  },
                  icon: Icon(Icons.image_search, size: 25),
                  label: Text("คลังรูปภาพ",style: TextStyle(fontSize: 20),),
                ),

                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton.icon(
                  onPressed: () {
                    _openCamera(context);
                  },
                  icon: Icon(Icons.camera_alt, size: 25),
                  label: Text("กล้องถ่ายรูป",style: TextStyle(fontSize: 20),),
                ),
                  // Padding(padding: EdgeInsets.all(8.0)),
                  // GestureDetector(
                  //   child: Center(child: Text("กล้องถ่ายรูป")),
                  //   onTap: () {
                  //     _openCamera(context);
                  //   },
                  // )
                ],
              ),
            ),
          );
        });
  }

// แสดงรูปภาพ
  Widget getImageWidget() {
    if (imageFile != null) {
      return Image.file(
        imageFile,
        width: 250,
        height: 350,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "img/placeholder.jpg",
        width: 250,
        height: 350,
        fit: BoxFit.cover,
      );
    }
  }

// แก้ไขรูปภาพ
  settingImage() async {
    this.setState(() {
      _inProcess = true;
    });
    // File image = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: imageFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blue[900],
            
            toolbarTitle: "ปรับแต่งรูปภาพ",
            statusBarColor: Colors.blue[900],
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        imageFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

//

//
  gotoPage() {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => Test12(imageFiles: imageFile),
    );
    Navigator.push(context, route);
    print(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาด้วยรูปภาพ'),
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
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              textColor: Colors.blue[900],
              borderSide: BorderSide(color: Colors.blue[900], width: 1.0, style: BorderStyle.solid),
              onPressed: () {
                _showChoiceDialog(context);
              },
              child: Text('Choose Image Type',style: TextStyle(fontSize: 18),),
            ),
            SizedBox(
              height: 20.0,
            ),
            getImageWidget(),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              color: Colors.blue[900],
              onPressed: () {
                imageFile == null
                    ? normalDialog(context, 'กรุณาเพิ่มรูปภาพ')
                    : settingImage();
              },
              child: Text('แก้ไขรูปภาพ',style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Colors.blue[900],
              onPressed: () {
                imageFile == null
                    ? normalDialog(context, 'กรุณาเพิ่มรูปภาพ')
                    : gotoPage();
              },
              child: Text('ค้นหาสายพันธุ์',style: TextStyle(color: Colors.white ,fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}
