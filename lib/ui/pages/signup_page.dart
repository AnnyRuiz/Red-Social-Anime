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
  //dependencia del controlador
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
              const Text(
                "Informacipn de registro",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              //campo de email
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration:
                      const InputDecoration(labelText: "correo electronico"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "correo electronico es obligatorio";
                    } else if (value.contains('@')) {
                      return "correo electronico debe tener @";
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              // campo password
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: pswdController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password es obligatorio";
                    } else if (value.length > 6) {
                      return "password debe ser mayor a 6 digitos";
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              // boton de registo
              TextButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    form!.save();
                    FocusScope.of(context).requestFocus(FocusNode());
                    //validacion formulario
                    if (_formKey.currentState!.validate()) {
                      _signup(emailController.text, pswdController.text);
                    }
                  },
                  child: const Text("registrar"))
            ],
          ),
        ),
      ),
    );
  }
}
