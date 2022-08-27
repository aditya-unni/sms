// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCasvxqzHXAlxyvfZ0GayhWlnCv4aWT8Zs',
    appId: '1:35695570798:web:92a6873830054a99661b7f',
    messagingSenderId: '35695570798',
    projectId: 'society-management-syste-1257d',
    authDomain: 'society-management-syste-1257d.firebaseapp.com',
    storageBucket: 'society-management-syste-1257d.appspot.com',
    measurementId: 'G-9EJNPCW0DE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxb4XocMjLN2F4jgbBj4ih2gNAlC3wPnI',
    appId: '1:35695570798:android:55fffe82a2275a7b661b7f',
    messagingSenderId: '35695570798',
    projectId: 'society-management-syste-1257d',
    storageBucket: 'society-management-syste-1257d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCc-Ke_cDUxvkxEx_yYk8V4eNtOQbX_6og',
    appId: '1:35695570798:ios:f1d39be82d9f03e7661b7f',
    messagingSenderId: '35695570798',
    projectId: 'society-management-syste-1257d',
    storageBucket: 'society-management-syste-1257d.appspot.com',
    iosClientId: '35695570798-sfnf25aviq8eq46i5lfsuk2sn4lsbbj6.apps.googleusercontent.com',
    iosBundleId: 'com.example.sms',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCc-Ke_cDUxvkxEx_yYk8V4eNtOQbX_6og',
    appId: '1:35695570798:ios:f1d39be82d9f03e7661b7f',
    messagingSenderId: '35695570798',
    projectId: 'society-management-syste-1257d',
    storageBucket: 'society-management-syste-1257d.appspot.com',
    iosClientId: '35695570798-sfnf25aviq8eq46i5lfsuk2sn4lsbbj6.apps.googleusercontent.com',
    iosBundleId: 'com.example.sms',
  );
}
