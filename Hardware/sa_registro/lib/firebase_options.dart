import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'FAKE-API-KEY-ANDROID',
    appId: '1:1234567890:android:abcdef123456',
    messagingSenderId: '1234567890',
    projectId: 'fake-project-id',
    storageBucket: 'fake-project-id.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'FAKE-API-KEY-IOS',
    appId: '1:1234567890:ios:abcdef123456',
    messagingSenderId: '1234567890',
    projectId: 'fake-project-id',
    storageBucket: 'fake-project-id.appspot.com',
    iosClientId: 'com.googleusercontent.apps.fakeclientid',
    iosBundleId: 'com.example.saRegistro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'FAKE-API-KEY-MAC',
    appId: '1:1234567890:macos:abcdef123456',
    messagingSenderId: '1234567890',
    projectId: 'fake-project-id',
    storageBucket: 'fake-project-id.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'FAKE-API-KEY-WIN',
    appId: '1:1234567890:windows:abcdef123456',
    messagingSenderId: '1234567890',
    projectId: 'fake-project-id',
    storageBucket: 'fake-project-id.appspot.com',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'FAKE-API-KEY-LINUX',
    appId: '1:1234567890:linux:abcdef123456',
    messagingSenderId: '1234567890',
    projectId: 'fake-project-id',
    storageBucket: 'fake-project-id.appspot.com',
  );
}
