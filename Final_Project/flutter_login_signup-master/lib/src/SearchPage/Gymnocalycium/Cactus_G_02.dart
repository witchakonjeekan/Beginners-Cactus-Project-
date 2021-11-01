import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShow.dart';
import 'package:flutter_login_signup/src/SearchPage/showProductShop.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShowSup.dart';
import 'package:flutter_login_signup/src/Widget/backgroudlogre.dart';
//import '/Widget/backgroudlogre.dart';

class AnisitsiiDamsiiPage extends StatefulWidget {
  @override
  _AnisitsiiDamsiipageState createState() => _AnisitsiiDamsiipageState();
}

class _AnisitsiiDamsiipageState extends State<AnisitsiiDamsiiPage> {

  String value = 'Gymnocalycium';
  String value2 = 'Anisitsii Damsii';

  Widget _HeaderName() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Gymnocalycium',
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
          Text(
            'Anisitsii Damsii',
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
          Text(
            'อะนิซิตซิอาย แดมซิอาย',
            style: TextStyle(
              fontSize: 19,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget _Imagecactus() {
    return Container(
      child: Image.asset(
        'img/Gymnocalyium/anisitsiidamsii.JPG',
        height: 250,
        width: 250,
      ),
    );
  }

  Widget _Storytext() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'เป็นยิมโยพันธุ์ที่เลี้ยงง่ายมาก โตเร็ว และออกดอกง่าย หาได้ทั่วไป เหมาะสำหรับผู้เลี้ยงมือใหม่ สามารถทนแดดและน้ำได้ดีและแตกหน่อได้ไว',
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'กระบองเพชรตระกูล Gymnocalycium เป็นไม้เนื้อแข็ง ทนแดดและทนน้ำได้ดี แต่ควรมีการพรางแสงบ้างเพื่อให้มีผิวที่สวย'
            'ศัตรูสำคัญคือเพลี้ยต่างๆ ซึ่งควรจะคอยสังเกตและคอยโรยยาฆ่าแมลงแบบเกล็ดเพื่อป้องกัน กระบองเพชรตระกูลนี้มักออกดอกช่วงต้นถึงกลางฤดูร้อนไทย',
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _iconWater() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 24.0,
          ),
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 24.0,
          ),
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 24.0,
          ),
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 24.0,
          ),
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 24.0,
          ),
        ],
      ),
    );
  }

  Widget _tablename() {
    return Container(
      child: Table(
        border: TableBorder.all(width: 2.0, color: Colors.grey),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {0: FlexColumnWidth(2.0), 1: FlexColumnWidth(3.0)},
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('ชื่อวิทยาศาสตร์'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('Gymnocalycium Anisitsii Damsii'),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('การรดน้ำ'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      // _iconWater(),
                      Center(
                        child: Text(
                            'รดน้ำได้ประมาน 1-2 วันครั้ง ทนต่อการเน่าได้ค่อนข้างดี'),
                      ),
                    ],
                    // child: Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Center(
                    //     child: Text(
                    //         'รดน้ำได้ประมาน 1-2 วันครั้ง ทนต่อการเน่าได้ค่อนข้างดี'),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('แสง'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                        'ชอบแดดทั้งวัน แต่ควรมรการพรางแสงบ้าง ให้ได้รับแดดประมาน 80%'),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('ทนความเย็นได้'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('-5 °C'),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('สีดอก'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('สีชมพู สีขาว'),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('แหล่งที่มา'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('Brazill,Bolivia,Paraguay'),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('ชื่อสามัญ'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('ยิมโนแม่ลูกดก'),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('แตกหน่อ'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('แตกหน่อเรื่อยๆ ตามอายุ'),
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('การขยายพันธุ์'),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('เมล็ดและแตกหน่อ'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${value} : ${value2}',
          textAlign: TextAlign.center,
        ),
         backgroundColor: Colors.blue[900],
      centerTitle: true,
      actions: [
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => ShowDataModel(value: value.trim()),
                  );
                  Navigator.push(context, route);
                },
                child: Tooltip(
                  message: 'สายพันธุ์หลัก',
                  child: Icon(IconData(0x1F335))),

              )),
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => ShowDataModelSup(value: value.trim(),
                    cactussup:value2.trim()),
                  );
                  Navigator.push(context, route);
                },
                 child: Tooltip(
                  message: 'สายพันธุ์ย่อย',
                  child: Icon(IconData(0x1F38B))),
              )),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG09.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        height: height,
        child: Stack(
          children: [
            
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            _HeaderName(),
                            _Imagecactus(),
                            _Storytext(),
                            SizedBox(
                              height: 15,
                            ),
                            _tablename(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // child: Stack(
        //   children: <Widget>[
        //     Positioned(child: BackgroundLogin()),
        //     //สร้างหน้าที่ไม่ชนกับขอบบนโทรศัพท์
        //     SafeArea(
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Row(
        //           children: [
        //             Column(
        //               children: <Widget>[
        //                 //สร้าง Row บนลงล่าง
        //                 Column(
        //                   children: <Widget>[
        //                     _HeaderName(),
        //                     _Imagecactus(),
        //                     _Storytext(),
        //                     _tablename(),
        //                   ],
        //                 ),

        //                 // Expanded(
        //                 //   child: GridView.count(
        //                 //     mainAxisSpacing: 10,
        //                 //     crossAxisSpacing: 10,
        //                 //     primary: false,
        //                 //     crossAxisCount: 2,
        //                 //     children: <Widget>[],
        //                 //   ),
        //                 // ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
