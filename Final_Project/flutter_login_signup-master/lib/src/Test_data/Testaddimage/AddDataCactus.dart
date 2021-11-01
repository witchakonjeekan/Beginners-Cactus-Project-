import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }




  Future uploadImage() async {
    final uri = Uri.parse("https://192.168.56.1/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/Uplordimage.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['subspecies'] = nameController.text;
    request.fields['detail'] = detailController.text;
    request.fields['price'] = priceController.text;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
      print(res.body);
  }
  

  @override
    Widget _entryFieldPrice(String title) {
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
            controller: priceController, //connectDB
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

  Widget _entryFieldDetail(String title) {
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
          Container(
            child: TextField(
              controller: detailController, //connectDB
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
              obscureText: false,
              maxLines: 7,
            ),
          ),
        ],
      ),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แอสโตรไฟรตรัม'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'ชื่อสายพันธุ์ย่อย'),
              ),
            ),
            OutlineButton(
              onPressed: choiceImage,
              child: Text('Choose Image'),
            ),
            Container(
              width: 200,
              child : _image == null ? Image.asset('img/01_logo.png'): Image.file(_image),
            ),
            SizedBox(height: 10,),
            _entryFieldPrice('ราคา'),
            SizedBox(height: 10,),
            _entryFieldDetail('รายละเอียด'),
            RaisedButton(
              child: Text('Upload Image'),
              onPressed: () {
                uploadImage();
              },
            ),
          ],
        ),
      ),
    );

  }
  
  
}


