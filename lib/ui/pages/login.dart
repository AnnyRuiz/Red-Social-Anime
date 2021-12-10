import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Red Max Anime",
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img_main.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Login Max Anime'),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Primer Input
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Usuario',
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                ),
                // Segundo Input
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contraseña',
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                ),
                // Boton de Registro
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    child: MaterialButton(
                      child: const Text("Registrarse!"),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/content');
            },
            tooltip: 'Login Max Anime',
            child: const Icon(Icons.login),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
