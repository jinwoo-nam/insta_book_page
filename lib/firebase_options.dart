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
    apiKey: 'AIzaSyCf5zXAHcH0LKeKhwu50XN_ZolFrCqbbuE',
    appId: '1:642460748747:web:6209ee6a789e27be31044e',
    messagingSenderId: '642460748747',
    projectId: 'instabooks-page',
    authDomain: 'instabooks-page.firebaseapp.com',
    storageBucket: 'instabooks-page.appspot.com',
    measurementId: 'G-T1WE3LWCE3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjQ1UGW06YpwyVMAqPvo380rq_qYgtAcc',
    appId: '1:642460748747:android:0118f6455ae843d431044e',
    messagingSenderId: '642460748747',
    projectId: 'instabooks-page',
    storageBucket: 'instabooks-page.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAlVtwiVzrTUcCg2fEbuLF1vgo6p8tc2Y',
    appId: '1:642460748747:ios:56cd0925a43e5f1031044e',
    messagingSenderId: '642460748747',
    projectId: 'instabooks-page',
    storageBucket: 'instabooks-page.appspot.com',
    iosClientId: '642460748747-h3slolq027v7hi7dh839ubfe5fun7s7i.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterGoogleSheetTest',
  );
}
