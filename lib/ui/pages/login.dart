import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_anime/ui/pages/principal.dart';
import 'package:max_anime/domain/use_cases/controllers/authentication_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailCtrl = TextEditingController();
  final pswdCtrl = TextEditingController();
  AuthController authController = Get.find();

  String mensaje = '';

  void login() async{
    bool correctUser = false;
    await authController.signIn(emailCtrl.text, pswdCtrl.text).then((value) => {
      correctUser = value
    });
    if(correctUser) {
      Get.offNamed('/principal');
    }else{
      print('maxanime: entre a mal');
      setState(() {
        mensaje = '${authController.mensaje}';
      });
    }
  }

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
                          labelText: 'Correo',
                        ),
                        onChanged: (text) {},
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
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
                        controller: pswdCtrl,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
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
                          Get.offNamed('/register');
                        },
                      ),
                    ),
                  ),
                  Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 30,
                        ),
                        child: Text(
                            mensaje,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                  )
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: login,
          tooltip: 'Login Max Anime',
          child: const Icon(Icons.login),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
  }
}
