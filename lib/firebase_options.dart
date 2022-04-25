// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDjVdrTPnsuagXwRF9ATfY8F09m1PCHbEs',
    appId: '1:165096878286:web:cf728f85ad95d37d5ba09f',
    messagingSenderId: '165096878286',
    projectId: 'chatflutter-eedbc',
    authDomain: 'chatflutter-eedbc.firebaseapp.com',
    storageBucket: 'chatflutter-eedbc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaVLwdNgo3xxpsU4ycF6og_2XOKtw8LiE',
    appId: '1:165096878286:android:9f77cfde28c668eb5ba09f',
    messagingSenderId: '165096878286',
    projectId: 'chatflutter-eedbc',
    storageBucket: 'chatflutter-eedbc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCahORUW-u6nVuh1gBfvtwPDhlqjk_K8PU',
    appId: '1:165096878286:ios:0f69a998fe8cd2265ba09f',
    messagingSenderId: '165096878286',
    projectId: 'chatflutter-eedbc',
    storageBucket: 'chatflutter-eedbc.appspot.com',
    androidClientId: '165096878286-lvv572vbs1ujp9h4feu55lsogjg75751.apps.googleusercontent.com',
    iosClientId: '165096878286-eu4kn1heq9d64js5b76b1ugcqrr4s0l4.apps.googleusercontent.com',
    iosBundleId: 'y',
  );
}
