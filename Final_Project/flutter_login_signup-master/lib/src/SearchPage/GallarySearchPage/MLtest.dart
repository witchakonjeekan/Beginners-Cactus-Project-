import 'dart:io';
// import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShow.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';

class LearningModelPage extends StatefulWidget {
  final File imageFiles;

  const LearningModelPage({Key key, this.imageFiles}) : super(key: key);

  @override
  _LearningModelPageState createState() => _LearningModelPageState();
}

class _LearningModelPageState extends State<LearningModelPage> {
  List _outputs;
  File imageFile;
  bool _loading = false;
  String value;
  var con;

  void initState() {
    super.initState();
    imageFile = widget.imageFiles;
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

    loadModel() async {
    await Tflite.loadModel(
      model: "asset/model_unquant.tflite",
      labels: "asset/labels.txt",
    );
    pickImage();
  }

  pickImage() async {
    var image = await imageFile;
    if (image == null) return null;
    setState(() {
      _loading = true;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 7,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
      print(_outputs);
      gotoPageShop(_outputs);
      // showDetailCactus(_outputs);
    });
  }

  gotoPageShop(_output) {
    value = "${_outputs[0]["label"]}".replaceAll(RegExp(r'[0-9]'), '');
    con = double.parse("${_outputs[0]["confidence"]}");
    // print('ความแม่นยำ : '+(con*100).toStringAsFixed(2)+ ' %');
  }

  // Future<Null> showDetailCactus(_output) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => SimpleDialog(
  //       title: MyStyle().showTitleH2(
  //         ("${_output[0]["label"]} -  ${_output[0]["confidence"].toStringAsFixed(2)}"),
  //       ),
  //       children: <Widget>[
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: <Widget>[
  //             FlatButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text('Close'),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget button() {
    return Container(
          child: MaterialButton(
            color: Colors.blue[900],
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
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Label Model'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG03.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'ผลลัพธ์การค้นหา',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            )),
            SizedBox(
              height: 20,
            ),
            _loading
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: <Widget>[
                            imageFile == null
                                ? Container()
                                : Image.file(
                                    imageFile,
                                    width: 300,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        _outputs != null
                            ? Column(
                                children: [
                                  Text(
                                    "คือสายพันธุ์  :  ${_outputs[0]["label"]}"
                                        .replaceAll(RegExp(r'[0-9]'), ''),
                                    // "${_outputs[0]["label"]}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      background: Paint()..color = Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    ('ความแม่นยำ : '+(con*100).toStringAsFixed(2)+ ' %'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      background: Paint()..color = Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  button(),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: pickImage,
      //   backgroundColor: Colors.red,
      //   child: Icon(Icons.image),
      // ),
    );
  }
}
