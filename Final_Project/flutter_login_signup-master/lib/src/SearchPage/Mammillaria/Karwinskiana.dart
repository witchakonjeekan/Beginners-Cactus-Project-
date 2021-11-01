import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShow.dart';
import 'package:flutter_login_signup/src/SearchPage/showProductShop.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShowSup.dart';
import 'package:flutter_login_signup/src/Widget/backgroudlogre.dart';

class KarwinskianaPage extends StatefulWidget {
  @override
  _KarwinskianapageState createState() => _KarwinskianapageState();
}

class _KarwinskianapageState extends State<KarwinskianaPage> {
  String value = 'Mammillaria';
  String value2 = 'Karwinskiana';

  Widget _HeaderName() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Mammillaria Karwinskiana',
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
          Text(
            'แมมมิลาเลีย คาร์วินสเกียนา',
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
        'img/Mammillaria/Karwinskiana.jpg',
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
            'ลักษณะเด่นของต้นกระบองเพชร แมมโฉมสกาว คือ จะมีเส้นขนสีขาวและขนกระจุกฟูสีขาวแทรกอยู่ระหว่างซอกพูหนาม หนามสีขาว หนามแหลมแข็งขน',
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'กระบองเพชรตระกูล Mammillaria เวลาแยกหน่อควรใช่ขนาดหน่อ 1 ใน 3 ของลำต้น'
            'แล้วจึกแยก พืชตระกูลนี้มีรากที่กระจายออกข้างและรากไม่ลึก ควรใช้กระถางที่หน้ากว้างและไม่ลึกมาก',
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
                    child: Text('Mammillaria Karwinskiana'),
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
                        child:
                            Text('รดน้ำเมื่อดินแห้ง ปกติประมาน 3-7วัน ครั้ง'),
                      ),
                    ],
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
                    child: Text('สีเหลือง'),
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
                    child: Text('Mexico'),
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
                    child: Text('แมมโฉมสกาว'),
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
                    child: Text('ไม่แตกหน่อ'),
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
                    child: Text('เมล็ด'),
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
      ),
    );
  }
}
