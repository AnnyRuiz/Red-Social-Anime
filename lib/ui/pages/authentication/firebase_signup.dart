import 'package:flutter/material.dart';
import 'package:red_max_anime/domain/controller/authentication_controller.dart';
import 'package:get/get.dart';

// Widget para el manejo de creacion de usuario
class FirebaseSignUp extends StatefulWidget {
  const FirebaseSignUp({Key? key}) : super(key: key);

  @override
  _FirebaseSignUpState createState() => _FirebaseSignUpState();
}

class _FirebaseSignUpState extends State<FirebaseSignUp> {
  // Llave del formulario para manejo de estados
  final _formKey = GlobalKey<FormState>();
  // Controladores de campos de texto
  final emailCtrl = TextEditingController();
  final pswdCtrl = TextEditingController();
  // Controlador de autenticacion
  AuthenticationController authCtrl = Get.find();

  // Metodo para crear un usuario
  _signup(theEmail, thePassword) async {
    try {
      await authCtrl.signUp(theEmail, thePassword);
      // Mensaje de informacion
      Get.snackbar(
        "Registrar Usuario",
        'Usuario registrado exitosamente!',
        icon: const Icon(Icons.person_add, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      // Mensaje de error
      Get.snackbar(
        "Registrar Usuario",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.white, BlendMode.dstATop),
                  image: AssetImage("assets/images/backgroundregistro.jpg"),
                  fit: BoxFit.cover)),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Registro de Usuario",
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
                TextButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    form!.save();
                    // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate()) {
                      _signup(emailCtrl.text, pswdCtrl.text);
                    }
                  },
                  child: const Text("Registrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
