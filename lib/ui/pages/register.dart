import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:max_anime/domain/use_cases/controllers/authentication_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailCtrl = TextEditingController();
  final pswdCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final lastCtrl = TextEditingController();
  final userCtrl = TextEditingController();
  AuthController authController = Get.find();

  String mensaje = '';

  void signup() async{
    bool correctUser = false;
    await authController.signUp(userCtrl.text, nameCtrl.text, lastCtrl.text, emailCtrl.text, pswdCtrl.text).then((value) => {
      correctUser = value
    });
    if(correctUser) {
      Get.offNamed('/login');
    }else{
      setState(() {
        mensaje = '${authController.mensajeReg}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuario',
                  ),
                  onChanged: (text) {},
                  controller: userCtrl,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                  ),
                  onChanged: (text) {},
                  controller: nameCtrl,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Apellido',
                  ),
                  onChanged: (text) {},
                  controller: lastCtrl,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onChanged: (text) {},
                  controller: emailCtrl,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                  onChanged: (text) {},
                  controller: pswdCtrl,
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
                      fontSize: 20,
                    ),
                  ),
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: signup,
        tooltip: 'Registrar',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
