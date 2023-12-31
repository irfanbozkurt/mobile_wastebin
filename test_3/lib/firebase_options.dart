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
    apiKey: 'AIzaSyDNAlbShBNJCG5j5KhCCBBqXxS2LeHT2-k',
    appId: '1:877501393555:web:6d188b0c14441605073b66',
    messagingSenderId: '877501393555',
    projectId: 'eldek-957c9',
    authDomain: 'eldek-957c9.firebaseapp.com',
    storageBucket: 'eldek-957c9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyP-5x7I3K2dqyCZiT2fiCFeFzmxSgKxo',
    appId: '1:877501393555:android:01f761cafe09c4c6073b66',
    messagingSenderId: '877501393555',
    projectId: 'eldek-957c9',
    storageBucket: 'eldek-957c9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7AbPeOaV8OiXbR5Oj8baCXVB9yeq6cmw',
    appId: '1:877501393555:ios:de7144250bc12a64073b66',
    messagingSenderId: '877501393555',
    projectId: 'eldek-957c9',
    storageBucket: 'eldek-957c9.appspot.com',
    iosBundleId: 'com.example.test03',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7AbPeOaV8OiXbR5Oj8baCXVB9yeq6cmw',
    appId: '1:877501393555:ios:2469ee6249b584bc073b66',
    messagingSenderId: '877501393555',
    projectId: 'eldek-957c9',
    storageBucket: 'eldek-957c9.appspot.com',
    iosBundleId: 'com.example.test03.RunnerTests',
  );
}
