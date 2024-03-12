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
    apiKey: 'AIzaSyAVUVvqKIWhVRK5Ic-3BZmNaxRAFxV69no',
    appId: '1:339470578297:web:1c745d2d3984a8a8ecdaa8',
    messagingSenderId: '339470578297',
    projectId: 'sewan-b94fe',
    authDomain: 'sewan-b94fe.firebaseapp.com',
    storageBucket: 'sewan-b94fe.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvrUDyGv4JM0ATvkWkBP-z6enl-i0kmPg',
    appId: '1:339470578297:android:348ebb824c725a4decdaa8',
    messagingSenderId: '339470578297',
    projectId: 'sewan-b94fe',
    storageBucket: 'sewan-b94fe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmyF41cjUXhuQTwib_zoTGvJqAy8ODQXQ',
    appId: '1:339470578297:ios:e837660824615872ecdaa8',
    messagingSenderId: '339470578297',
    projectId: 'sewan-b94fe',
    storageBucket: 'sewan-b94fe.appspot.com',
    iosBundleId: 'com.example.sewan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmyF41cjUXhuQTwib_zoTGvJqAy8ODQXQ',
    appId: '1:339470578297:ios:82288bf4daa96488ecdaa8',
    messagingSenderId: '339470578297',
    projectId: 'sewan-b94fe',
    storageBucket: 'sewan-b94fe.appspot.com',
    iosBundleId: 'com.example.sewan.RunnerTests',
  );
}
