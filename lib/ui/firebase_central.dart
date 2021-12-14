import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/authentication/firebase_login.dart';
import 'pages/content_page.dart';

// Widget principal
class FirebaseCentral extends StatelessWidget {
  const FirebaseCentral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const ContentPage();
        } else {
          return const FirebaseLogIn();
        }
      },
    );
  }
}