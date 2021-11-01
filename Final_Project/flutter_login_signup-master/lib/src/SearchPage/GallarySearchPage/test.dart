import 'dart:io';
// import 'package:flutter_login_signup/src/Widget/StyleUng.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShow.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/allshow.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:percent_indicator/percent_indicator.dart';

class Test12 extends StatefulWidget {
  final File imageFiles;

  const Test12({Key key, this.imageFiles}) : super(key: key);

  @override
  _Test12State createState() => _Test12State();
}

class _Test12State extends State<Test12> {
  List _outputs;
  File imageFile;
  String value;
  String valuetest;
  String choose;
  int index = 0;

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
      numResults: 3,
      threshold: 0,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _outputs = output;
      print(_outputs);
      // gotoPageShop(_outputs);
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

  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.brown
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ผลลัพธ์การค้นหา')),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        actions: [
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
          SizedBox(
            width: 5,
          ),
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () async {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => SingleChildScrollView(
                      child: AlertDialog(
                        title: const Text('รายละเอียดของสายพันธุ์'),
                        content: Row(
                          children: [
                            Column(
                              children: [
                                Text('สี'),
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.color_lens,
                                  color: colors[0],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Icon(
                                  Icons.color_lens,
                                  color: colors[1],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Icon(
                                  Icons.color_lens,
                                  color: colors[2],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Icon(
                                  Icons.color_lens,
                                  color: colors[3],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Icon(
                                  Icons.color_lens,
                                  color: colors[4],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Icon(
                                  Icons.color_lens,
                                  color: colors[5],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Icon(
                                  Icons.color_lens,
                                  color: colors[6],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              children: [
                                Text('Class'),
                                SizedBox(
                                  height: 25,
                                ),
                                Text('Astrophytum'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Coryphantha'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Gymnocalycium'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Lophophora'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Mammillaria'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('แคคตัสสายพันธุ์อื่น'),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('ไม่ใช่แคคตัส'),
                              ],
                            )
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Icon(Icons.contact_support_outlined ),
              )),
        ],
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
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'รูปภาพ มีความคล้ายคลึงกับสายพันธ์ุ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
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
              Column(
                children: [
                  // Center(
                  //     child: Text(
                  //   'มีความคล้ายคลึงกับสายพันธ์ุ',
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 20.0,
                  //       fontWeight: FontWeight.bold),
                  // )),
                  SingleChildScrollView(
                    child: Column(
                      children: _outputs != null
                          ? _outputs.map((result) {
                              return Card(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: ("${result["label"]}"
                                                          .replaceAll(
                                                              RegExp(r'[0-9]'),
                                                              ''))
                                                      .trim() ==
                                                  'Othercactus'
                                              ? Text(
                                                  'แคคตัสสายพันธุ์อื่นๆ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : ("${result["label"]}"
                                                              .replaceAll(
                                                                  RegExp(
                                                                      r'[0-9]'),
                                                                  ''))
                                                          .trim() ==
                                                      'No a cactus'
                                                  ? Text(
                                                      'ไม่ใช่แคคตัส',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      "${result["label"]}"
                                                          .replaceAll(
                                                              RegExp(r'[0-9]'),
                                                              ''),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: new LinearPercentIndicator(
                                                width:
                                                    MediaQuery.of(context).size.width -
                                                        70,
                                                animation: true,
                                                lineHeight: 20.0,
                                                animationDuration: 2500,
                                                percent: double.parse(
                                                    result["confidence"]
                                                        .toStringAsFixed(2)),
                                                center: Center(
                                                  child: Text(
                                                    (100 *
                                                                double.parse(result[
                                                                        "confidence"]
                                                                    .toStringAsFixed(
                                                                        2)))
                                                            .toInt()
                                                            .toString() +
                                                        " %",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                linearStrokeCap:
                                                    LinearStrokeCap.roundAll,
                                                // progressColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
                                                progressColor: "${result["label"]}"
                                                            .replaceAll(
                                                                RegExp(
                                                                    r'[0-9]'),
                                                                '')
                                                            .trim() ==
                                                        'Astrophytum'
                                                    ? colors[0]
                                                    : "${result["label"]}".replaceAll(RegExp(r'[0-9]'), '').trim() ==
                                                            'Coryphantha'
                                                        ? colors[1]
                                                        : "${result["label"]}"
                                                                    .replaceAll(RegExp(r'[0-9]'), '')
                                                                    .trim() ==
                                                                'Gymnocalycium'
                                                            ? colors[2]
                                                            : "${result["label"]}".replaceAll(RegExp(r'[0-9]'), '').trim() == 'Lophophora'
                                                                ? colors[3]
                                                                : "${result["label"]}".replaceAll(RegExp(r'[0-9]'), '').trim() == 'Mammillaria'
                                                                    ? colors[4]
                                                                    : "${result["label"]}".replaceAll(RegExp(r'[0-9]'), '').trim() == 'Othercactus'
                                                                        ? colors[5]
                                                                        : colors[6]),
                                          ),
                                          IconButton(
                                            tooltip: 'ค้นหาร้านค้า',
                                            icon: Icon(
                                              Icons.search,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowDataModel(
                                                        value:
                                                            "${result["label"]}"
                                                                .replaceAll(
                                                                    RegExp(
                                                                        r'[0-9]'),
                                                                    '')
                                                                .trim()),
                                              );
                                              Navigator.push(context, route);
                                              print(
                                                "${result["label"]}"
                                                    .replaceAll(
                                                        RegExp(r'[0-9]'), '')
                                                    .trim(),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue[900],
                    onPressed: () {
                      gotoPage();
                    },
                    child: Text(
                      'ผลลัพธ์ทั้งหมด',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  // gotoPageShop(_outputs),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // buttongopage()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  gotoPage() {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => test123(imageFiles: imageFile),
    );
    Navigator.push(context, route);
    print(imageFile);
  }
}
