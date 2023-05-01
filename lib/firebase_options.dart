
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2gNbNkXVPMW0PpPuIxQkHtf5IncBW_1M',
    appId: '1:916812813546:android:bf3368057833e81d47f393',
    messagingSenderId: '916812813546',
    projectId: 'kenz-market',
    storageBucket: 'kenz-market.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBK_Wsp4aNkzxrU7mCC8QRivHLWxj2BnDU',
    appId: '1:916812813546:ios:4436de71215873d047f393',
    messagingSenderId: '916812813546',
    projectId: 'kenz-market',
    storageBucket: 'kenz-market.appspot.com',
    androidClientId: '916812813546-kf7tm1anfvm430dt3j1u206nca16jmv7.apps.googleusercontent.com',
    iosClientId: '916812813546-qpk6t888g0k3tnk3q8urd4gq5tk99n5h.apps.googleusercontent.com',
    iosBundleId: 'com.kenzmarket.application',
  );
}
