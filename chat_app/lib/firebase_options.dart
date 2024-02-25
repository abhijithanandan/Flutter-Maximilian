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
    apiKey: 'AIzaSyCwe8fyNWNhrRn-_jpvedArCJ3RoWpqMvM',
    appId: '1:208896189555:web:f4c99aaef082b2d0f07606',
    messagingSenderId: '208896189555',
    projectId: 'chat-app-e7add',
    authDomain: 'chat-app-e7add.firebaseapp.com',
    storageBucket: 'chat-app-e7add.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5CYFUJszomjdfIMNJihRiNUTWtPWIb-U',
    appId: '1:208896189555:android:931360abdff6029cf07606',
    messagingSenderId: '208896189555',
    projectId: 'chat-app-e7add',
    storageBucket: 'chat-app-e7add.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9RvSETKNBSfYcVtSX0rAz3ysuJDAO-Wo',
    appId: '1:208896189555:ios:fb835fc72316759ff07606',
    messagingSenderId: '208896189555',
    projectId: 'chat-app-e7add',
    storageBucket: 'chat-app-e7add.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB9RvSETKNBSfYcVtSX0rAz3ysuJDAO-Wo',
    appId: '1:208896189555:ios:7b7950c2cf542108f07606',
    messagingSenderId: '208896189555',
    projectId: 'chat-app-e7add',
    storageBucket: 'chat-app-e7add.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
