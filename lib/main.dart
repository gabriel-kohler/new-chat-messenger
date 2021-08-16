import 'package:app_chat_messenger/views/auth_screen.dart';
import 'package:app_chat_messenger/views/chat_screen.dart';
import 'package:app_chat_messenger/views/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/*


SDK VERSION :  sdk: ">=2.7.0 <3.0.0"


*/

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _init = Firebase.initializeApp();

    return FutureBuilder(
        future: _init,
        builder: (ctx, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: snapshot.connectionState == ConnectionState.waiting
                ? SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.hasData) {
                        return ChatScreen();
                      } else {
                        return AuthScreen();
                      }
                    },
                  ),
          );
        });
  }
}
