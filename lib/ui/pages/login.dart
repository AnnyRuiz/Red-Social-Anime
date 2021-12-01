import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_anime/ui/pages/principal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Login Max Anime'),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/imags/fondo.jpg'), fit: BoxFit.cover)),
            child: Center(
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
                          //Navigator.pushNamed(context, '/register');
                          Get.toNamed('/register');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BaseNavegacion())
            );*/
            Get.offNamed('/principal');
          },
          tooltip: 'Login Max Anime',
          child: const Icon(Icons.login),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
  }
}
