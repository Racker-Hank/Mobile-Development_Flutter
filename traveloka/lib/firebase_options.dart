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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAPb8chJI3t9vr_wryV55DnIXRmMfDfQYg',
    appId: '1:1037927517632:web:299ffb4a94c97162bc0c25',
    messagingSenderId: '1037927517632',
    projectId: 'flutterfire-codelab-85e94',
    authDomain: 'flutterfire-codelab-85e94.firebaseapp.com',
    storageBucket: 'flutterfire-codelab-85e94.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBq5gWmOfLJDybSkxfLb2WDL-jgkfEJpCU',
    appId: '1:1037927517632:android:0555adf510c29485bc0c25',
    messagingSenderId: '1037927517632',
    projectId: 'flutterfire-codelab-85e94',
    storageBucket: 'flutterfire-codelab-85e94.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAr8WTD3Ptp3RmMmc7vnOEB4-1ek70U00',
    appId: '1:1037927517632:ios:2d47b16e6fd7a624bc0c25',
    messagingSenderId: '1037927517632',
    projectId: 'flutterfire-codelab-85e94',
    storageBucket: 'flutterfire-codelab-85e94.appspot.com',
    iosClientId: '1037927517632-f629h07mvgc904lubcl94rrckd1rm6fk.apps.googleusercontent.com',
    iosBundleId: 'com.example.traveloka',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBdHwiFdEoHcCAIck3rnMdscVV3rZwetaE',
    appId: '1:1037927517632:web:ec5f5e6da9a60c83bc0c25',
    messagingSenderId: '1037927517632',
    projectId: 'flutterfire-codelab-85e94',
    authDomain: 'flutterfire-codelab-85e94.firebaseapp.com',
    storageBucket: 'flutterfire-codelab-85e94.appspot.com',
  );
}
