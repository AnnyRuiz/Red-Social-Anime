import 'package:flutter/material.dart';
import 'package:max_anime/ui/pages/content.dart';
import 'package:max_anime/ui/pages/login.dart';
import 'package:max_anime/ui/pages/register.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Red Max Anime',
      theme: ThemeData(brightness: Brightness.dark
          //primarySwatch: Colors.blueGrey,
          ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const LoginPage(
              title: 'Login',
            ),
        '/register': (context) => const RegisterPage(
              title: 'Registro',
            ),
        '/content': (context) => const ContentPage(title: 'Posts'),
      },
    );
  }
}
