import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _HandlerState();
}

//clase manejadora de estado
class _HandlerState extends State<SignupPage> {
  //manejador de estado del formulario
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pswdController = TextEditingController();
  AuthController ctrl = Get.find();

  //metodo de creacion
  _signup(email, password) async {
    try {
      await ctrl.signup(email, password);
      Get.snackbar("Registro", "usuario registrado exitosamente!",
          icon: const Icon(Icons.person_add, color: Colors.blue),
          snackPosition: SnackPosition.TOP);
      emailController.clear();
      pswdController.clear();
    } catch (e) {
      Get.snackbar("Registro", "Error:${e.toString()}",
          icon: const Icon(Icons.person_add, color: Colors.red),
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de usuarios"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Informacipn de registro",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
