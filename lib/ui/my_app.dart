import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:max_anime/domain/controller/authentication_controller.dart';
import 'package:max_anime/domain/controller/chat_controller.dart';
import 'package:max_anime/domain/controller/chats_controller.dart';
import 'package:max_anime/domain/controller/firestore_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'firebase_central.dart';

class MyApp extends StatelessWidget {
  // Se inicializa el contexto de firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // Constructor
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Demo - MisionTIC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            logError("error ${snapshot.error}");
            return const Wrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Get.put(FirebaseController());
            Get.put(AuthenticationController());
            Get.put(ChatController());
            Get.put(ChatsController());
            return const FirebaseCentral();
          }
          return const Loading();
        },
      )),
    );
  }
}

class Wrong extends StatelessWidget {
  const Wrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Ocurrio un error!"));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}