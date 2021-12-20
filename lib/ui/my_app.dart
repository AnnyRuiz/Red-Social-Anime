import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:red_max_anime/domain/controller/authentication_controller.dart';
import 'package:red_max_anime/domain/controller/chat_controller.dart';
import 'package:red_max_anime/domain/controller/chats_controller.dart';
import 'package:red_max_anime/domain/controller/firestore_controller.dart';
import 'package:red_max_anime/domain/controller/persona_controller.dart';

import 'package:red_max_anime/domain/use_case/controllers/theme_controller.dart';
import 'package:red_max_anime/domain/use_case/theme_management.dart';
import 'package:red_max_anime/ui/theme/theme.dart';

import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'firebase_central.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // Se inicializa el contexto de firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // Dependency injection: setting up state management
  late final ThemeController controller = Get.put(ThemeController());
  // Theme management
  late final ThemeManager manager = ThemeManager();
  bool isLoaded = false;

  Future<void> initializeTheme() async {
    controller.darkMode = await manager.storedTheme;
    setState(() => isLoaded = true);
  }

  @override
  void initState() {
    ever(controller.reactiveDarkMode, (bool isDarkMode) {
      manager.changeTheme(isDarkMode: isDarkMode);
    });
    initializeTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const CircularProgressIndicator()
        : GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Red Max Animes',
            theme: MyTheme.ligthTheme,
            darkTheme: MyTheme.darkTheme,
            themeMode: ThemeMode.system,
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
                  Get.put(PersonaController());
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
