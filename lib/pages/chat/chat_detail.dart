//@dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sms/helper/constants.dart';
import 'package:sms/models/chat_info.dart';
import 'package:sms/models/message.dart';
import 'package:sms/pages/chat/widgets/custom_chat_bubble.dart';
import 'package:sms/services/message.dart';
import 'package:sms/services/user.dart';

import '../../models/user.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  UserModel user;
  UserModel self;
  UserServices userServices = UserServices();

  DatabaseReference chatref, offsetRef;
  Query initialList;

  loadChatContent(UserModel user) {
    offsetRef = database.ref().child('.info/serverTimeOffset');
    chatref = database
        .ref()
        .child(CHAT_REF)
        .child(getRoomID(auth.currentUser.uid, user.id));

    initialList = database
        .ref()
        .child(CHAT_REF)
        .child(getRoomID(auth.currentUser.uid, user.id))
        .orderByChild("sentAt");
    return initialList;
  }

  String getRoomID(String a, String b) {
    if (a.compareTo(b) > 0) {
      return a + b;
    } else {
      return b + a;
    }
  }

  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Get.find<UserModel>();
    createName(auth.currentUser.uid);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<UserModel>();
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MessageServcie messageServcie = MessageServcie();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    child: Text(
                      "${user.name.substring(0, 1)}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${user.name}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        // Text(
                        //   "Online",
                        //   style: TextStyle(
                        //       color: Colors.grey.shade600, fontSize: 13),
                        // ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: FirebaseAnimatedList(
              controller: _scrollController,
              // sort: (a, b) {
              //   if (a.value != null && b.value != null) {
              //     DateTime ats = DateTime.fromMillisecondsSinceEpoch(
              //             (a.value as Map<dynamic, dynamic>)['sentAt'])
              //         .toLocal();
              //     DateTime bts = DateTime.fromMillisecondsSinceEpoch(
              //             (b.value as Map<dynamic, dynamic>)['sentAt'])
              //         .toLocal();
              //     return ats.isBefore(bts) ? 1 : 0;
              //   }
              //   return 0;
              // },
              reverse: false,
              query: loadChatContent(user),
              itemBuilder: (context, snapshot, animation, index) {
                var messages = MessageModel.fromJson(
                    json.decode(json.encode(snapshot.value)));

                return SizeTransition(
                  sizeFactor: animation,
                  // child: Align(
                  //   alignment: (messages.senderId != auth.currentUser.uid
                  //       ? Alignment.topLeft
                  //       : Alignment.topRight),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: (messages.senderId != auth.currentUser.uid
                  //           ? Colors.grey.shade200
                  //           : Colors.blue[200]),
                  //     ),
                  //     padding: EdgeInsets.all(16),
                  //     child: Text(
                  //       messages.content,
                  //       style: TextStyle(fontSize: 15),
                  //     ),
                  //   ),
                  // ),
                  child: CustomChatBubble(
                    isMe: messages.senderId == auth.currentUser.uid,
                    text: messages.content,
                    user: messages.senderName,
                    time: DateFormat('hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(messages.sentAt)),
                  ),
                );
              },
            )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (_textEditingController.text != "") {
                          offsetRef.once().then((DatabaseEvent snapshot) {
                            var offset = snapshot.snapshot.value as int;
                            var estimatedServerTimeInMs =
                                DateTime.now().millisecondsSinceEpoch + offset;

                            submitChat(estimatedServerTimeInMs);
                          }).catchError((e) => print(e));
                          autoScroll(_scrollController);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter Some Text")));
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  submitChat(int estimatedServerTimeInMs) async {
    MessageModel messageModel = MessageModel();
    // await userServices
    //     .getUserById(auth.currentUser.uid)
    //     .then((value) => messageModel.senderName = value.name);
    messageModel.senderName = self.name;
    messageModel.content = _textEditingController.text;
    messageModel.sentAt = estimatedServerTimeInMs;
    messageModel.senderId = auth.currentUser.uid;

    submitChatToFirebase(messageModel, estimatedServerTimeInMs);
  }

  void autoScroll(ScrollController scrollController) {
    Timer(Duration(milliseconds: 100), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    });
  }

  void autoScrollReverse(ScrollController scrollController) {
    Timer(Duration(milliseconds: 100), () {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    });
  }

  createName(String id) async {
    self = await userServices.getUserById(id);
  }

  void submitChatToFirebase(
      MessageModel messageModel, int estimatedServerTimeInMs) {
    chatref.get().then((value) {
      if (!value.children.isEmpty) {
        appendChat(messageModel, estimatedServerTimeInMs);
      } else {
        createChat(messageModel, estimatedServerTimeInMs);
      }
    }).catchError((e) => print(e));
  }

  void createChat(MessageModel messageModel, int estimatedServerTimeInMs) {
    ChatInfo chatInfo = ChatInfo(
      createId: auth.currentUser.uid,
      friendName: user.name,
      friendId: user.id,
      createName: self.name,
      lastMessage: messageModel.content,
    );
    database
        .ref()
        .child(CHATLIST_REF)
        .child(auth.currentUser.uid)
        .child(user.id)
        .set(chatInfo.toJson())
        .then((value) {
      database
          .ref()
          .child(CHATLIST_REF)
          .child(user.id)
          .child(auth.currentUser.uid)
          .set(chatInfo.toJson())
          .then((value) {
        chatref.push().set(<String, dynamic>{
          'content': messageModel.content,
          'senderId': messageModel.senderId,
          'senderName': messageModel.senderName,
          'sentAt': messageModel.sentAt
        }).then((value) {
          _textEditingController.text = "";
          // autoScrollReverse(_scrollController);
        }).catchError((e) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("1"))));
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("2")));
      });
    }).catchError((e) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("3"))));
  }

  void appendChat(MessageModel messageModel, int estimatedServerTimeInMs) {
    var update_data = Map<String, dynamic>();
    update_data['lastUpdate'] = estimatedServerTimeInMs;
    update_data['lastMessage'] = messageModel.content;
    database
        .ref()
        .child(CHATLIST_REF)
        .child(auth.currentUser.uid)
        .child(user.id)
        .update(update_data)
        .then((value) {
      database
          .ref()
          .child(CHATLIST_REF)
          .child(user.id)
          .child(auth.currentUser.uid)
          .update(update_data)
          .then((value) {
        chatref.push().set(<String, dynamic>{
          'content': messageModel.content,
          'senderId': messageModel.senderId,
          'senderName': messageModel.senderName,
          'sentAt': messageModel.sentAt
        }).then((value) {
          _textEditingController.text = "";
          // autoScrollReverse(_scrollController);
        }).catchError((e) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Message Not Sent"))));
      }).catchError((e) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Cannot Update Friend Chat List"))));
    }).catchError((e) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Cannot Update User Chat List"))));
  }
}
