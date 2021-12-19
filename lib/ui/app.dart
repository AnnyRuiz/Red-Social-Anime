import 'package:flutter/material.dart';
import 'package:max_anime/ui/pages/chats.dart';
import 'package:max_anime/ui/pages/login.dart';
import 'package:max_anime/ui/pages/principal.dart';
import 'package:max_anime/ui/pages/register.dart';
import 'package:max_anime/ui/pages/ubicacion.dart';
import 'package:max_anime/ui/pages/new_post.dart';
import 'package:max_anime/ui/pages/new_conv.dart';
import 'theme/theme.dart';
import 'package:get/get.dart';
import 'pages/chats.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Red Max Anime',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/principal', page: () => Principal(), transition: Transition.zoom),
        GetPage(name: '/chats', page: () => Chats()),
        GetPage(name: '/ubicacion', page: () => Ubicacion('Barranquilla')),
        GetPage(name: '/new_post', page: () => NewPost()),
        GetPage(name: '/new_chat', page: () => NewConversation()),
      ],
    );
  }
}
