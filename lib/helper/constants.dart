import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sms/firebase_options.dart';

final Future<FirebaseApp> initialization =
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;

const CHAT_REF = "chats";
const CHATLIST_REF = "chatlist";
const MESSAGE_REF = "message";
