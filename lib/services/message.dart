//@dart=2.9
import 'package:firebase_database/firebase_database.dart';
import 'package:sms/models/user.dart';
import 'package:sms/helper/constants.dart';

class MessageServcie {
  String collection = "messages";
  final CHAT_REF = "chats";
  final MESSAGE_REF = "message";
  DatabaseReference chatref, offsetRef;

  void sendMessage({
    UserModel sender,
    String content,
  }) {}

  loadChatContent(UserModel user) {
    offsetRef = database.ref().child('.info/serverTimeOffset');
    chatref = database
        .ref()
        .child(CHAT_REF)
        .child(getRoomID(auth.currentUser.uid, user.id));

    return chatref;
  }

  String getRoomID(String a, String b) {
    if (a.compareTo(b) > 0) {
      return a + b;
    } else {
      return b + a;
    }
  }
}
