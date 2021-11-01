import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/ChatApp/Chat_userTouser.dart';
import 'package:flutter_login_signup/src/ChatApp/DB_Firebase/ChatRoomDB.dart';
import 'package:flutter_login_signup/src/Model/UserModel_FB.dart';
import 'package:flutter_login_signup/src/Widget/Message_Chack.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatroomPage extends StatefulWidget {
  final String chatname;
  ChatroomPage({Key key, this.chatname}) : super(key: key);

  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  String chatnameFB;
  String usernameFB, emailFB, passwordFB, typeFB, MyProfileFB;
  String MyProfile, MyUsername, MyEmail;
  UserModelFB modelFB = UserModelFB();
  String Email, Password;
  bool isSearching = false;
  Stream userStream, chatRoomStream;

  TextEditingController SearchUsername = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatnameFB = widget.chatname;
    User();
    onScreenLoaded();
    getautochat();
  }

  Future<Null> User() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      usernameFB = preferences.getString('Username');
      emailFB = preferences.getString('Email');
      passwordFB = preferences.getString('Password');
      typeFB = preferences.getString('Status');
      MyProfileFB = preferences.getString('Image_Profile');
      print('Email ==> $emailFB and Password ==> $passwordFB');
    });
    LoginFirebase(emailFB, passwordFB);
  }

  Future<Null> getUserintoSharedPerference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      MyProfile = preferences.getString('Image_Profile');
      MyUsername = preferences.getString('Username');
      MyEmail = preferences.getString('Email');
    });
    setState(() {});
  }

  Future<Null> LoginFirebase(String emailFB, String passwordFB) async {
    Email = emailFB;
    Password = passwordFB;
    await Firebase.initializeApp().then((value) async {
      // UserModelFB modelFB = UserModelFB(email: Email, password: Password);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: Password)
          .then((value) => print('LoginFirebase Succeed'));
      // Navigator.push(
      // context, MaterialPageRoute(builder: (context) => ChatroomPage()))
    });
  }

  onSearchBtnClick() async {
    if (usernameFB == SearchUsername.text) {
      normalDialog(context, 'ไม่สามารถ Chat กับตัวเองได้');
    } else{
      isSearching = true;
    setState(() {});
    userStream = await getUserByUsername(SearchUsername.text); //
    setState(() {});
    print(chatnameFB);
    }
    // isSearching = true;
    // setState(() {});
    // userStream = await getUserByUsername(SearchUsername.text); //
    // setState(() {});
    // print(chatnameFB);
  }

  getautochat() async {
    if (chatnameFB != null) {
      isSearching = true;
      setState(() {});
      userStream = await getUserByUsername(chatnameFB.trim());
      // SearchUserList();
      setState(() {});
    }
  }

  getChatRoomIDByUser(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget SearchListUserTile({String email, username}) {
    // String ProfileUrl,email, username ถ้ามีรูปให้ใส่
    return GestureDetector(
      onTap: () {
        var ChatRoomID = getChatRoomIDByUser(MyUsername, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "user": [MyUsername, username]
        };
        CreateChatRoom(ChatRoomID, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(email, username)));
      },
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(40),
          //   child: Image.network(
          //     ProfileUrl,
          //     height: 30,
          //     width: 30,
          //   ),
          // ),
          // SizedBox(
          //   width: 12,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(username), Text(email)],
          ),
        ],
      ),
    );
  }

  Widget SearchUserList() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data.docs[index];
                  print("ds ===> $doc");
                  return SearchListUserTile(
                      email: doc.data()["email"] ?? '',
                      username: doc.data()["username"] ??
                          ''); // ds["ProfileUrl"] ถ้ามีรูปให้ใส่
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  // Widget chatRoomListTile(String MyUsername, String lastMessage) {
  //   return Row(
  //     children: [
  //       Image.network(
  //           'https://qph.fs.quoracdn.net/main-qimg-5ce873a40eaedee31a122adafbf6f256'),
  //       Column(
  //         children: [Text(""), Text(lastMessage)],
  //       ),
  //     ],
  //   );
  // }

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return ChatRoomListTile(
                      ds.data()["lastMessage"], ds.id, MyUsername);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget SearchChatuser() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              // isSearching
              //     ? GestureDetector(
              //         onTap: () {
              //           isSearching = false;
              //           SearchUsername.text = "";
              //           setState(() {});
              //         },
              //         child: Padding(
              //             padding: EdgeInsets.only(right: 12),
              //             child: Icon(Icons.arrow_back)),
              //       )
              //     : Container(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: SearchUsername,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'ค้นหา'),
                      )),
                      GestureDetector(
                          onTap: () {
                            if (SearchUsername.text != "") {
                              onSearchBtnClick();
                              // getUserByUsername(SearchUsername.text);
                            }
                          },
                          child: Icon(Icons.search)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          isSearching ? SearchUserList() : ChatRoomList(),
        ],
      ),
    );
  }

  Widget ShowError() {
    Fluttertoast.showToast(
        msg: "ไม่มีบัญชีผู้ใช้นี้",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ShowgetChatRoom() async {
    chatRoomStream = await getChatRoom();
    setState(() {});
  }

  onScreenLoaded() async {
    await getUserintoSharedPerference();
    ShowgetChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ห้องแชท'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SearchChatuser(),
          ],
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, ChatRoomID, MyUsername;
  ChatRoomListTile(this.lastMessage, this.ChatRoomID, this.MyUsername);
  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String MyProfile = "", username = "", name = "", email = "";

  getThisUserInfo() async {
    username =
        widget.ChatRoomID.replaceAll(widget.MyUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await getUserInfo(username);
    // print("something ha ha ha ${querySnapshot.docs[0].id}");
    name = "${querySnapshot.docs[0]["username"]}";
    // MyProfile = querySnapshot.docs[0]["Image_Profile"]; // รูปภาพ
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThisUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(email, username)));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              'http://cdn-icons-png.flaticon.com/512/1946/1946429.png', // MyProfile
              height: 40,
              width: 40,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ชื่อผู้ใช้ : $name',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(
                height: 3,
              ),
              Text('ข้อความล่าสุด ==> ${widget.lastMessage}')
            ],
          ),
        ],
      ),
    );
  }
}
