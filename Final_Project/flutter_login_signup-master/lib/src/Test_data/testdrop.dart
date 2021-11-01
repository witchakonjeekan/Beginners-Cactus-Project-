import 'package:flutter/material.dart';

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override


  String mainspecies = null;
  List<DropdownMenuItem<String>> _dropDownItemCactusB() {
    List<String> cactusb = [
      "Astrophytum",
      "Coryphantha",
      "Gymnocalycium",
      "Lophophora",
      "Mammillaria",
      "ไม่แน่ชัด"
    ];
    return cactusb
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  Widget _ButtonCactus02() {
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
            hint: Text("สายพันธ์หลัก"),
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_ButtonCactus02()],
        ),
      ),
    );
  }
}
