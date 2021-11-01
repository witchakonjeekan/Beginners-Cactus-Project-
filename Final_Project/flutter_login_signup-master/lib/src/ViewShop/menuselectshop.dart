import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/ViewShop/ShowShopAll.dart';
import 'package:flutter_login_signup/src/ViewShop/pagefaver.dart';

class SelectPageShop extends StatefulWidget {
  // const SelectPageShop({ Key? key }) : super(key: key);

  @override
  _SelectPageShopState createState() => _SelectPageShopState();
}

class _SelectPageShopState extends State<SelectPageShop> {
  // Widget GotoShopPage() {
  //   return InkWell(
  //     onTap: () {
  //       print('GotoShop');
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(
  //         left: 40,
  //         right: 40,
  //       ),
  //       width: MediaQuery.of(context).size.width,
  //       padding: EdgeInsets.symmetric(vertical: 15),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(40),
  //           ),
  //           boxShadow: <BoxShadow>[
  //             BoxShadow(
  //                 color: Color(0xffdf8e33).withAlpha(100),
  //                 offset: Offset(2, 4),
  //                 blurRadius: 8,
  //                 spreadRadius: 2)
  //           ],
  //           color: Colors.orange[700]),
  //       child: Text(
  //         'ร้านค้าทั้งหมด',
  //         style: TextStyle(fontSize: 25, color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  // Widget GotoFavoritesPage() {
  //   return InkWell(
  //     onTap: () {
  //       print('GotoShop');
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(
  //         left: 40,
  //         right: 40,
  //       ),
  //       width: MediaQuery.of(context).size.width,
  //       padding: EdgeInsets.symmetric(vertical: 15),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(40),
  //           ),
  //           boxShadow: <BoxShadow>[
  //             BoxShadow(
  //                 color: Color(0xffdf8e33).withAlpha(100),
  //                 offset: Offset(2, 4),
  //                 blurRadius: 8,
  //                 spreadRadius: 2)
  //           ],
  //           color: Colors.orange[700]),
  //       child: Text(
  //         'ร้านค้าที่คุณถูกใจ',
  //         style: TextStyle(fontSize: 25, color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  Widget _planetThumbnailShop() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopShow()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
        child: Image(
          image: AssetImage("img/02_logo.png"),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );
  }

  Widget _planetCardShop() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopShow()));
      },
      child: Container(
        height: 124.0,
        margin: EdgeInsets.only(left: 46.0),
        child: Center(
          child: Text(
            "ร้านค้าทั้งหมด",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF1565C0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget GotoShopPage() {
    return Container(
      margin: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
        left: 24.0,
        right: 24.0,
      ),
      child: Stack(
        children: <Widget>[_planetCardShop(), _planetThumbnailShop()],
      ),
    );
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget _planetThumbnailFavorites() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => favoritShop()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
        child: Image(
          image: AssetImage("img/noti01.jpg"),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );
  }

  Widget _planetCardFavorites() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => favoritShop()));
      },
      child: Container(
        height: 124.0,
        margin: EdgeInsets.only(left: 46.0),
        child: Center(
          child: Text(
            "ร้านค้าที่ติดตาม",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF1565C0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget GotoFavoritesPage() {
    return Container(
      margin: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
        left: 24.0,
        right: 24.0,
      ),
      child: Stack(
        children: <Widget>[_planetCardFavorites(), _planetThumbnailFavorites()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกรายการที่คุณต้องการ'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login_BG02.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  GotoShopPage(),
                  SizedBox(
                    height: 15,
                  ),
                  GotoFavoritesPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
