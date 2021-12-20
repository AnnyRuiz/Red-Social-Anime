import 'package:flutter/material.dart';
import 'package:red_max_anime/data/model/persona.dart';
import 'package:red_max_anime/domain/controller/authentication_controller.dart';
import 'package:red_max_anime/domain/controller/persona_controller.dart';
import 'package:get/get.dart';

// Widget encargado de la creacion de una persona
class CrearWidget extends StatefulWidget {
  const CrearWidget({Key? key}) : super(key: key);

  @override
  _CrearWidgetState createState() => _CrearWidgetState();
}

class _CrearWidgetState extends State<CrearWidget> {
  // Llave del formulario para manejo de estados
  final _formKey = GlobalKey<FormState>();
  // Controladores de campos de texto
  final nombCtrl = TextEditingController();
  // Inyeccion de controladores
  PersonaController personaController = Get.find();
  AuthenticationController authenticationController = Get.find();

  // Metodo para crear una persona
  _crearPersona(Persona persona) async {
    try {
      // Se invoca futuro para la creacion
      await personaController.agregar(persona);
      // Limpiar el formulario
      nombCtrl.clear();
      // Mensaje informativo
      Get.snackbar(
        "Creacion de Post",
        "Post creado exitosamente!",
        icon: const Icon(
          Icons.person_add,
          color: Colors.red,
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Creacion de Post",
        "Error: ${e.toString()}",
        icon: const Icon(
          Icons.person_add,
          color: Colors.red,
        ),
      );
    }
  }

  // Crear widget para representar el formulario
  Widget formulario() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Expanded(
            child: ListView(
              children: [
                const Text(
                  "Nuevo Post",
                  style: TextStyle(fontSize: 20),
                ),

                // Campo para el nombre
                TextFormField(
                  controller: nombCtrl,
                  decoration: const InputDecoration(labelText: " "),
                  validator: (value) {
                    // Valida que no se vacio
                    if (value!.isEmpty) {
                      return "La descripción es obligatoria!";
                    }
                  },
                ),

                TextButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    form!.save();
                    // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate()) {
                      Persona persona = Persona(nombCtrl.text);
                      _crearPersona(persona);
                    }
                  },
                  child: const Text("Crear"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: formulario(),
        ),
      ],
    );
  }
}
