import 'package:flutter/material.dart';
import 'package:red_max_anime/data/model/persona.dart';
import 'package:red_max_anime/domain/controller/authentication_controller.dart';
import 'package:red_max_anime/domain/controller/persona_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

// Widget encargado de la creacion de una persona
class VisualizarWidget extends StatefulWidget {
  const VisualizarWidget({Key? key}) : super(key: key);

  @override
  _VisualizarWidgetState createState() => _VisualizarWidgetState();
}

class _VisualizarWidgetState extends State<VisualizarWidget> {
  // Controlador para manejo de scroll
  late ScrollController _scrollController;
  // Inyeccion de controladores
  PersonaController personController = Get.find();
  AuthenticationController authenticationController = Get.find();

  get child => null;

  // Se altera el ciclo vida del Widget para el inicio
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    personController.iniciar();
  }

  // Se altera el ciclo vida del Widget para la destruccion
  @override
  void dispose() {
    _scrollController.dispose();
    personController.detener();
    super.dispose();
  }

  // Widget que se encarga de mostrar los mensajes
  Widget _item(Persona element, int posicion, String uid) {
    logInfo('Post? -> ${element.toString()}');
    return Card(
      margin: const EdgeInsets.all(15),
      color: Colors.white38,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Fila del Documento
            Row(
              children: [
                const Text(
                  "Post:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(element.nomb)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  element.usua,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(" "),
                Text(
                  element.fecha.toDate().toString().substring(0, 16),
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget que se encarga de la creacion del listado
  Widget _list() {
    String uid = authenticationController.userEmail();
    logInfo('Id del usuario actual $uid');
    return GetX<PersonaController>(builder: (controller) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
      // Ordenar por fechas
      personController.records.sort((a, b) => a.fecha.compareTo(b.fecha));
      return ListView.builder(
        itemCount: personController.records.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          var element = personController.records[index];
          return _item(element, index, uid);
        },
      );
    });
  }

  // Metodo encargado de la animacion del scroll
  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
    return Column(
      children: [
        Expanded(flex: 4, child: _list()),
      ],
    );
  }
}
