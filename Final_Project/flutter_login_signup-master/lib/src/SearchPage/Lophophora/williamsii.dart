import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShow.dart';
import 'package:flutter_login_signup/src/SearchPage/showProductShop.dart';
import 'package:flutter_login_signup/src/SearchPage/GallarySearchPage/PageShowSup.dart';
import 'package:flutter_login_signup/src/Widget/backgroudlogre.dart';

class williamsiiPage extends StatefulWidget {
  @override
  _williamsiipageState createState() => _williamsiipageState();
}

class _williamsiipageState extends State<williamsiiPage> {

  String value = 'Lophophora';
  String value2 = 'Williamsii';

  Widget _HeaderName() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Lophophora Williamsii',
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
          Text(
            'โลโฟโฟรา วิลเลียมซิอาย',
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
        'img/Lophophora/williamsii.jpg',
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
            'เป็นสายพันธุ์ที่ชอบอยู่ต้นโดดเดี่ยวลำต้นรูปทรงกลม แบน สีเขียวเข้ม สีเทา มีขนสีขาวอยู่บนยอดและลำต้นชอบอาศัยอยู่ในธรรมชาติ เป็นรากแก้วโขดขนาดใหญ่ เติบโตช้าและชอบแสแดดน้อย'
            'ปุ๋ยและน้ำควรให้ปริมาณน้อยถ้ามากเกินไปลำต้นจะแตก',
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'เป็นแคคตัสตระกูล Lophophora นั้นไม่มีหนาม ควรรดน้ำเมื่อดินแห้งเนื่องจากเน่าง่าย หากต้นมีอายุมากขึ้นจะมีขนข้างบน ระวังอย่ารดน้ำโดนขนเ้านบนเพราะจะทำให้ขนแข็งและเสียรูป'
            'บางครั้งลำต้นอาจจะนิ่มมากแต่เมื่อได้รับน้ำและสิ่งแวดล้อมเหมาะสมจะกลับมาแข็งเหมือนเดิม',
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
                    child: Text('Lophophora williamsii'),
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
                      Center (
                        child: Text('ควรรดน้ำให้ความถี่น้อยกว่าพันธุ์อื่น'),
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
                        'สามารถอยู่ได้ทั้งที่พรางแสงหรือร่มรำไร หรือแดดตรงอย่างน้อยกว่าครึ่งวัน'),
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
                    child: Text('-7 °C'),
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
                    child: Text('สีขาว สีชมพู'),
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
                    child: Text(''),
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
                    child: Text('ไม่ค่อยแตกหน่อ หรือแตกเมื่อกราฟ'),
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
                    child: Text('เมล็ดและกราฟ'),
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
        title: Text('${value} : ${value2}', textAlign: TextAlign.center,),
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
