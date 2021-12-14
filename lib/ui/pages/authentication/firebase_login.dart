import 'package:flutter/material.dart';
import 'package:max_anime/domain/controller/authentication_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'firebase_signup.dart';

// Widget para el manejo de inicio de sesion
class FirebaseLogIn extends StatefulWidget {
  const FirebaseLogIn({Key? key}) : super(key: key);

  @override
  _FirebaseLogInState createState() => _FirebaseLogInState();
}

class _FirebaseLogInState extends State<FirebaseLogIn> {
  // Llave del formulario para manejo de estados
  final _formKey = GlobalKey<FormState>();
  // Controladores de campos de texto
  final emailCtrl = TextEditingController();
  final pswdCtrl = TextEditingController();
  // Controlador de autenticacion
  AuthenticationController authCtrl = Get.find();

  // Metodo de autenticacion
  _login(theEmail, thePassword) async {
    logInfo('Autenticacion de $theEmail $thePassword');
    try {
      await authCtrl.login(theEmail, thePassword);
    } catch (err) {
      // Widget para mostrar mensajes
      Get.snackbar(
        "Inicio de Sesión",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Inicio de Sesión con Correo",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Campo para el Correo Electronico
                TextFormField(
                  // El campo me va proporcionar un teclado exclusivo
                  // para escribir correos electronicos
                  keyboardType: TextInputType.emailAddress,
                  controller: emailCtrl,
                  decoration:
                      const InputDecoration(labelText: "Correo Electronico"),
                  validator: (value) {
                    // Valida que haya digitado un correo
                    if (value!.isEmpty) {
                      return "Correo Electronico es obligatorio!";
                      // Valida que sea un correo correcto
                    } else if (!value.contains('@')) {
                      return "Correo Electronico no cumple las politicas!";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // Campo para la Contraseña
                TextFormField(
                  // El campo me va proporcionar un teclado exclusivo
                  // para escribir solo numeros
                  keyboardType: TextInputType.number,
                  controller: pswdCtrl,
                  decoration: const InputDecoration(labelText: "Contraseña"),
                  obscureText: true,
                  validator: (value) {
                    // Valida que haya digitado una contraseña
                    if (value!.isEmpty) {
                      return "Contraseña es obligatoria!";
                      // Valida longitud del campo
                    } else if (value.length < 6) {
                      return "Contraseña debe ser mayor o igual a 6 digitos!";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () async {
                    // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                    FocusScope.of(context).requestFocus(FocusNode());
                    final form = _formKey.currentState;
                    form!.save();
                    if (_formKey.currentState!.validate()) {
                      await _login(emailCtrl.text, pswdCtrl.text);
                    }
                  },
                  child: const Text("Ingresar"),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirebaseSignUp()));
            },
            child: const Text("Registrarse"),
          )
        ],
      ),
    );
  }
}