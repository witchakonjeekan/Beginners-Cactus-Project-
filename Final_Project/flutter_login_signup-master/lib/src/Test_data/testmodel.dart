import 'dart:io';
// import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShow.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';

class Test123 extends StatefulWidget {
  final File imageFiles;

  const Test123({Key key, this.imageFiles}) : super(key: key);

  @override
  _Test12State createState() => _Test12State();
}

class _Test12State extends State<Test123> {
  List _outputs;
  File imageFile;
  String value;
  String valuetest;

  void initState() {
    super.initState();
    imageFile = widget.imageFiles;
    loadModel();
  }

  Future pickImage() async {
    var image = await imageFile;
    classifyImage(image);
  }

  Future classifyImage(File image) async {
    final List output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.01,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _outputs = output;
      print(_outputs);
      gotoPageShop(_outputs);
      // showDetailCactus(_outputs);
    });
  }

  loadModel() async {
    Tflite.close();
    String res;
    res = await Tflite.loadModel(
      model: "asset/model_unquant.tflite",
      labels: "asset/labels.txt",
    );
    print(res);
    // await Tflite.loadModel(
    //   model: "asset/model_unquant.tflite",
    //   labels: "asset/labels.txt",
    // );
    pickImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  gotoPageShop(_output) {
    value = "${_outputs[0]["label"]}".replaceAll(RegExp(r'[0-9]'), '');
  }

  Widget button() {
    return Container(
      child: Row(children: <Widget>[
        Expanded(
          child: MaterialButton(
            color: Colors.pink,
            child: Text('ค้นหาร้านค้าที่เกี่ยวข้อง',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => ShowDataModel(value: value.trim()),
              );
              Navigator.push(context, route);
              print(imageFile);
              //  showDetailCactus(_outputs);
            },
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Label Model'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text('ผลลัพธ์การค้นหา'),
          SizedBox(
            height: 10,
          ),
          imageFile != null
              ? Container(
                  margin: EdgeInsets.all(10),
                  child: Image.file(
                    imageFile,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ))
              : Container(
                  margin: EdgeInsets.all(40),
                  child: Opacity(
                    opacity: 0.6,
                    child: Center(
                      child: Text('No Image Selected!'),
                    ),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Column(
              children: _outputs != null
                  ? _outputs.map((result) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text(
                                "${result["label"]}"
                                    .replaceAll(RegExp(r'[0-9]'), ''),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // Text("${100*(double.parse("${result["confidence"].toStringAsFixed(2)}"))}"),
                              Text(
                                (100 *
                                            double.parse(result["confidence"]
                                                .toStringAsFixed(2)))
                                        .toInt()
                                        .toString() +
                                    " %",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList()
                  : [],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: pickImage,
      //   backgroundColor: Colors.red,
      //   child: Icon(Icons.image),
      // ),
    );
  }
}
