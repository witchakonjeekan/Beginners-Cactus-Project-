import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/ChatApp/DB_Firebase/ChatRoomDB.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show Random;

class ChatScreen extends StatefulWidget {
  // const ChatScreen({ Key key }) : super(key: key);

  final String ChatWithUsername, username;
  ChatScreen(this.ChatWithUsername, this.username);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String ChatRoomID, MessageID = "";
  Stream messageStreamm;
  String MyProfile, MyUsername, MyEmail;
  TextEditingController MessageController = TextEditingController();

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  getUserintoSharedPerference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      MyProfile = preferences.getString('Image_Profile');
      MyUsername = preferences.getString('Username');
      MyEmail = preferences.getString('Email');
    });

    ChatRoomID = getChatRoomIDByUser(widget.username, MyUsername);
  }

  getChatRoomIDByUser(String a, String b) {
    print("$b\_$a");
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessages(bool sendCliecked) {
    if (MessageController.text != "") {
      String message = MessageController.text;

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": MyUsername,
        "ts": lastMessageTs,
        // "imgUrl" : MyProfile
      };

      //MessageID
      if (MessageID == "") {
        MessageID = randomAlphaNumeric(12);
      }

      addMessageByUser(ChatRoomID, MessageID, messageInfoMap)
          .then((value) async {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": MyUsername,
        };

        updateLastMessage(ChatRoomID, lastMessageInfoMap);

        if (sendCliecked) {
          // ส่งข้อความใหม่ไปยัง User อีกคน
          MessageController.text = "";
          //
          MessageID = "";
        }
      });
    } else {}
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment: sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomRight: sendByMe ? Radius.circular(0) : Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: sendByMe ?  Radius.circular(24) : Radius.circular(0),
            ),
            color: Colors.blue,
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
        stream: messageStreamm,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return chatMessageTile(ds["message"], MyUsername == ds["sendBy"]);
                  })
              : Center(child: CircularProgressIndicator());
        });
  }

  getAndSetMessages() async {
    messageStreamm = await getChatRoomMessages(ChatRoomID);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getUserintoSharedPerference();
    getAndSetMessages();
  }

  Widget IconSend() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        color: Colors.grey.withOpacity(0.8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                  controller: MessageController,
                  onChanged: (value) {
                    addMessages(false);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "กรุณาใส่ข้อความ",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(1),
                      ))),
            ),
            GestureDetector(
              onTap: () {
                addMessages(true);
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            IconSend(),
          ],
        ),
      ),
    );
  }
}
