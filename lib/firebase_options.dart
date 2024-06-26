// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuQ6S7FRzvyBcOqvz3KvgGuspgg2Nk7GU',
    appId: '1:1054968151369:android:0ac4842c4cac0280a72e98',
    messagingSenderId: '1054968151369',
    projectId: 'ai-shapers',
    storageBucket: 'ai-shapers.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAarNINPpxHQW17lZ7iuu7vmSPLXK0CLsg',
    appId: '1:1054968151369:web:785f6a6a94f788a7a72e98',
    messagingSenderId: '1054968151369',
    projectId: 'ai-shapers',
    authDomain: 'ai-shapers.firebaseapp.com',
    storageBucket: 'ai-shapers.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAarNINPpxHQW17lZ7iuu7vmSPLXK0CLsg',
    appId: '1:1054968151369:web:3bcd6ec45954a305a72e98',
    messagingSenderId: '1054968151369',
    projectId: 'ai-shapers',
    authDomain: 'ai-shapers.firebaseapp.com',
    storageBucket: 'ai-shapers.appspot.com',
  );

}