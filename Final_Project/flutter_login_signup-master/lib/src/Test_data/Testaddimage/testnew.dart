import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class testeiei extends StatefulWidget {

  @override
  _testeieiState createState() => _testeieiState();
}

class _testeieiState extends State<testeiei> {
  File _image;
  List _results;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image classification'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickAnImage,
        tooltip: 'Select Image',
        child: Icon(Icons.image),
      ),
      body: Column(
        children: [
          if (_image != null)
            Container(margin: EdgeInsets.all(10), child: Image.file(_image))
          else
            Container(
              margin: EdgeInsets.all(40),
              child: Opacity(
                opacity: 0.6,
                child: Center(
                  child: Text('No Image Selected!'),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: _results != null
                  ? _results.map((result) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "${result["label"]} -  ${result["confidence"].toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList()
                  : [],
            ),
          ),
        ],
      ),
    );
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = await Tflite.loadModel(
      model: "asset/model_unquant.tflite",
      labels: "asset/labels.txt",
    );
    print(res);
  }

  Future pickAnImage() async {
    // pick image and...
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // Perform image classification on the selected image.
    imageClassification(image);
  }

  Future imageClassification(File image) async {
    // Run tensorflowlite image classification model on the image
    final List results = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = results;
      _image = image;
    });
  }
}