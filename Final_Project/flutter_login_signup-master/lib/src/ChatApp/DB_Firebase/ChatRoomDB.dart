import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<Stream<QuerySnapshot>> getUserByUsername(String username) async {
  return FirebaseFirestore.instance
      .collection('user')
      .where('username', isEqualTo: username)
      .snapshots();
}

Future addMessageByUser(
    String ChatRoomID, String MessageID, Map messageInfoMap) async {
  return FirebaseFirestore.instance
      .collection("Chatroom")
      .doc(ChatRoomID)
      .collection("Chat")
      .doc(MessageID)
      .set(messageInfoMap);
}

updateLastMessage(String ChatRoomID, Map lastMessageInfoMap) async {
  return FirebaseFirestore.instance
      .collection("Chatroom")
      .doc(ChatRoomID)
      .update(lastMessageInfoMap);
}

CreateChatRoom(String ChatRoomID, Map chatRoomInfoMap) async {
  final SnapShot = await FirebaseFirestore.instance
      .collection("Chatroom")
      .doc(ChatRoomID)
      .get();

  if (SnapShot.exists) {
    // ใน Chatroom มีค่าอยู่
    return true;
  } else {
    // ถ้าไม่มีค่า
    return FirebaseFirestore.instance
        .collection("Chatroom")
        .doc(ChatRoomID)
        .set(chatRoomInfoMap);
  }
}

Future<Stream<QuerySnapshot>> getChatRoomMessages(ChatRoomID) async {
  return FirebaseFirestore.instance
      .collection("Chatroom")
      .doc(ChatRoomID)
      .collection("Chat")
      .orderBy("ts", descending: true)
      .snapshots();
}

Future<Stream<QuerySnapshot>> getChatRoom() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String MyUsername = preferences.getString('Username');
  return FirebaseFirestore.instance
      .collection("Chatroom")
      .orderBy("lastMessageSendTs", descending: true)
      .where("user", arrayContains: MyUsername)
      .snapshots();
}

Future<QuerySnapshot> getUserInfo(String username) async {
  return await FirebaseFirestore.instance
      .collection("user")
      .where("username", isEqualTo: username)
      .get();
}
