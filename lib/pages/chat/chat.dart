//@dart=2.9
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sms/constants/controllers.dart';
import 'package:sms/helper/constants.dart';
import 'package:sms/models/chat_info.dart';
import 'package:sms/models/user.dart';
import 'package:sms/pages/chat/chat_detail.dart';
import 'package:sms/services/user.dart';

import '../../helper/responsiveness.dart';
import '../../widgets/custom_text.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(icon: Icon(Icons.chat), text: "Chat"),
    Tab(icon: Icon(Icons.people), text: "All")
  ];

  final UserServices userServices = UserServices();

  TabController _tabController;

  Stream<DatabaseEvent> chatlistref = database
      .ref()
      .child(CHATLIST_REF)
      .child(auth.currentUser.uid)
      .onValue
      .asBroadcastStream();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 86 : 6,
                        left: ResponsiveWidget.isSmallScreen(context) ? 26 : 0),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          bottom: new TabBar(
            tabs: tabs,
            controller: _tabController,
            isScrollable: false,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black45,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            if (e.text == "Chat")
              return LoadChatList();
            else
              return loadPeople();
          }).toList(),
        ));
  }

  Widget loadPeople() {
    return FutureBuilder(
        future: userServices.getAll(),
        builder: ((context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.hasData) {
            List<UserModel> userModels = [];
            for (UserModel user in snapshot.data) {
              if (user.id != auth.currentUser.uid) {
                userModels.add(user);
              }
            }

            return ListView.builder(
                itemCount: userModels.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.put(userModels[index]);
                      Get.to(() => ChatDetailPage());
                    },
                    child: Column(children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Text(
                            "${userModels[index].name.substring(0, 1)}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text("${userModels[index].name}"),
                      ),
                      Divider(
                        thickness: 2,
                      )
                    ]),
                  );
                }));
          } else {
            return Container();
          }
        }));
  }
}

class LoadChatList extends StatelessWidget {
  const LoadChatList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<DatabaseEvent> chatlistref = database
        .ref()
        .child(CHATLIST_REF)
        .child(auth.currentUser.uid)
        .onValue
        .asBroadcastStream();
    return StreamBuilder(
        stream: chatlistref,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            List<ChatInfo> chatInfos = [];
            chatInfos.clear();
            Iterable<DataSnapshot> values = snapshot.data.snapshot.children;

            values.forEach((value) {
              Map<String, dynamic> temp = json.decode(json.encode(value.value));
              var chatInfo = ChatInfo.fromJson(json.decode(json.encode(temp)));
              chatInfos.add(chatInfo);
            });

            return ListView.builder(
                itemCount: chatInfos.length,
                itemBuilder: ((context, index) {
                  var displayName =
                      auth.currentUser.uid == chatInfos[index].createId
                          ? chatInfos[index].friendName
                          : chatInfos[index].createName;
                  return Consumer<Object>(builder: ((context, value, child) {
                    return GestureDetector(
                      onTap: () async {
                        firebaseFirestore
                            .collection("users")
                            .doc(auth.currentUser.uid ==
                                    chatInfos[index].createId
                                ? chatInfos[index].friendId
                                : chatInfos[index].createId)
                            .get()
                            .then((doc) {
                          if (doc != null) {
                            final UserModel userModel =
                                UserModel.fromSnapshot(doc);
                            Get.put(userModel);
                            Get.to(ChatDetailPage());
                          }
                        });
                      },
                      child: Column(children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            child: Text(
                              "${displayName.substring(0, 1)}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text("${displayName}"),
                          subtitle: Text("${chatInfos[index].lastMessage}"),
                          isThreeLine: true,
                        ),
                        Divider(
                          thickness: 2,
                        )
                      ]),
                    );
                  }));
                }));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
