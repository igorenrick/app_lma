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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBqilXge5OtSATBndNRA1Z7CBnArle7i2I',
    appId: '1:438515634042:web:1eb32ff056e211d0ee10c3',
    messagingSenderId: '438515634042',
    projectId: 'lma-app-40d4f',
    authDomain: 'lma-app-40d4f.firebaseapp.com',
    storageBucket: 'lma-app-40d4f.appspot.com',
    measurementId: 'G-XWSDFNZJHB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGDJh_ZwceMl1pKCchZbXWyT5pjXZlmXM',
    appId: '1:438515634042:android:05f5e7764e86e312ee10c3',
    messagingSenderId: '438515634042',
    projectId: 'lma-app-40d4f',
    storageBucket: 'lma-app-40d4f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5qDd6qBqQm5ZkiPQbhm4wxdUyDqM990I',
    appId: '1:438515634042:ios:68eb1296ef550dabee10c3',
    messagingSenderId: '438515634042',
    projectId: 'lma-app-40d4f',
    storageBucket: 'lma-app-40d4f.appspot.com',
    iosClientId: '438515634042-7ko935mt8s9r3246iqm18didsopc2ga3.apps.googleusercontent.com',
    iosBundleId: 'com.ufsc.applma',
  );
}
