// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class Addimage extends StatefulWidget {
//   @override
//   _AddimageState createState() => _AddimageState();
// }

// class _AddimageState extends State<Addimage> {

//   static const ADD_CATEGORY_URL = "";
//   TextEditingController nameController = TextEditingController();

//   bool checkStatus = false;
//   int categoryStatus;

//   File imageFile;
//   String imageData;

//   choiceImage() async {
//     var pickedImage = await ImagePicker().getImage(sorce: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         imageFile = File(pickedImage.path);
//       });
//       imageData = base64Encode(imageFile.readAsBytesSync()); 
//       return imageData;
//     } else {
//       return null;
//     }
//   }

//   Future addCategory() async {
//     var data = {
//       "DataDB": nameController.text,
//       "DataDB1": imageData,
//       "DataDB2": categoryStatus.toString(),
//     };
//     var response = await http.post(ADD_CATEGORY_URL, body: data);
//     if (response.statusCode == 200) {
//       print(response.body);
//       Fluttertoast.showToast(
//           msg: "สำเร็จ",);
//     }
//   }

//   showImage(String image) {
//     return Image.memory(base64Decode(image));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Category'),
//       ),
//       body: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 25),
//             child: TextField(
//               controller: nameController,
//               decoration: InputDecoration(hintText: 'Enter Category name'),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(left: 25),
//                 child: IconButton(
//                   iconSize: 40,
//                   icon: Icon(Icons.image),
//                   onPressed: () {
//                     choiceImage();
//                   },
//                 ),
//               ),
//               imageData == null ? Text("no image Selected"): Container(child: showImage(ImageData),width: 70,height: 70,),
//             ],  
//           )
//         ],
//       ),
//     );
//   }
// }
