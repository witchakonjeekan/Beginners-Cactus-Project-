import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/UserNormal/HomePage.dart';
import 'package:flutter_login_signup/src/UserShop/HomePageShop.dart';
import 'package:flutter_login_signup/src/UserShop/ManageShop/ManageShopandCactus/AddandEdit/PageCheckCactus.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        )
      ],
    ),
  );
}



Future<void> normalDialogEditUser(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                onPressed: () async{
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
                          false); 
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        )
      ],
    ),
  );
}

Future<void> normalDialogpage(BuildContext context, String message) async {
  //AddDataCactus รอแอดมิน
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreenShop())),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        )
      ],
    ),
  );
}

Future<void> normalDialog2(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: Image.asset('img/email_logo.png'),
        title: Text(title,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        
        subtitle: Text(message,style: TextStyle(fontSize: 18),),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        )
      ],
    ),
  );
}
