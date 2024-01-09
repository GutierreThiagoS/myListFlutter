

import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseMessagingService {

  void getToken() {
    FirebaseMessaging.instance.getToken().then((token) {
      // Use o token
    });

  }
}