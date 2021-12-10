import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:red_maxanime/ui/pages/signup_page.dart';
import 'ui/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //inyectar controlador
  Get.put(AuthController());
  //iniciar logs
  Loggy.initLoggy(
      logPrinter: const PrettyPrinter(
    showColors: true,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Red Social Max Anime",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snap) {
          if (snap.hasError) {
            return Text("Error: ${snap.error}");
          } else if (snap.connectionState == ConnectionState.done) {
            return const SignupPage();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

/*void main() {
  // this is the key
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  runApp(MyApp());
}*/
