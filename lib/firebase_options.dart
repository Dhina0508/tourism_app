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
    apiKey: 'AIzaSyAWanIi30uAUrr6VXGyzM-b8i0n4NW6snI',
    appId: '1:993841443952:web:d92619d57f5044d72230b5',
    messagingSenderId: '993841443952',
    projectId: 'tourist-a0d14',
    authDomain: 'tourist-a0d14.firebaseapp.com',
    databaseURL: 'https://tourist-a0d14-default-rtdb.firebaseio.com',
    storageBucket: 'tourist-a0d14.appspot.com',
    measurementId: 'G-1HXL87KNE6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBntgtGzeKgqCnUXOsxoOEO3fzXUXmmfFY',
    appId: '1:993841443952:android:312441eadd83c93f2230b5',
    messagingSenderId: '993841443952',
    projectId: 'tourist-a0d14',
    databaseURL: 'https://tourist-a0d14-default-rtdb.firebaseio.com',
    storageBucket: 'tourist-a0d14.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzx2AOXrvtNarYF15CBGRhuarWL2jFetk',
    appId: '1:993841443952:ios:095d0a19b28280872230b5',
    messagingSenderId: '993841443952',
    projectId: 'tourist-a0d14',
    databaseURL: 'https://tourist-a0d14-default-rtdb.firebaseio.com',
    storageBucket: 'tourist-a0d14.appspot.com',
    iosClientId: '993841443952-56eddcn8chaveup84ihn5foj4ekt3ign.apps.googleusercontent.com',
    iosBundleId: 'com.example.tourism',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzx2AOXrvtNarYF15CBGRhuarWL2jFetk',
    appId: '1:993841443952:ios:095d0a19b28280872230b5',
    messagingSenderId: '993841443952',
    projectId: 'tourist-a0d14',
    databaseURL: 'https://tourist-a0d14-default-rtdb.firebaseio.com',
    storageBucket: 'tourist-a0d14.appspot.com',
    iosClientId: '993841443952-56eddcn8chaveup84ihn5foj4ekt3ign.apps.googleusercontent.com',
    iosBundleId: 'com.example.tourism',
  );
}
