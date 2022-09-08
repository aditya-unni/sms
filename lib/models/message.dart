//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class MessageModel {
  static const CONTENT = "content";
  static const SENDER_ID = "senderId";
  static const SENDER_NAME = "senderName";
  static const SENT_AT = "sentAt";

  String content;
  String senderId;
  String senderName;
  int sentAt;

  MessageModel({this.content, this.senderId, this.senderName, this.sentAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json[CONTENT];
    senderId = json[SENDER_ID];
    senderName = json[SENDER_NAME];
    sentAt = json[SENT_AT];
  }
}
