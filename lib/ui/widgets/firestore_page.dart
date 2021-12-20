import 'package:flutter/material.dart';
import 'package:red_max_anime/data/model/record.dart';
import 'package:red_max_anime/domain/controller/firestore_controller.dart';
import 'package:red_max_anime/domain/use_case/controllers/theme_controller.dart';
import 'package:red_max_anime/ui/pages/response/screens/response_screen.dart';
import 'package:get/get.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

// Widget para el manejo de los datos
class FireStorePage extends StatefulWidget {
  const FireStorePage({Key? key}) : super(key: key);

  @override
  State<FireStorePage> createState() => _FireStorePageState();
}

class _FireStorePageState extends State<FireStorePage> {
  // Inyectar dependencia del controlador
  final FirebaseController firebaseController = Get.find();
  final ThemeController controller = Get.find();

  // Se altera el ciclo vida del Widget para el inicio
  @override
  void initState() {
    firebaseController.suscribeUpdates();
    super.initState();
  }

  // Se altera el ciclo vida del Widget para la destruccion
  @override
  void dispose() {
    firebaseController.unsuscribeUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addBaby(context);
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: ResponseScreen(controller: controller),
        ),
      ),
      drawer: Drawer(
        child: Obx(
          () => ListView.builder(
            itemCount: firebaseController.entries.length,
            padding: const EdgeInsets.only(top: 20.0),
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(context, firebaseController.entries[index]);
            },
          ),
        ),
      ),
    );
  }

  // Widget que construye la visualizacion de un item
  Widget _buildItem(BuildContext context, Record record) {
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => firebaseController.updateEntry(record),
          onLongPress: () => firebaseController.deleteEntry(record),
        ),
      ),
    );
  }

  // Metodo que permite agregar un nuevo registro
  Future<void> addBaby(BuildContext context) async {
    getName(context).then((value) {
      firebaseController.addEntry(value);
    });
  }

  // Metodo que abre una ventana para obtener datos del usuario
  Future<String> getName(BuildContext context) async {
    String? result = await prompt(
      context,
      title: const Text('Zona de votación Anime red max'),
      initialValue: '',
      textOK: const Text('Publicar'),
      textCancel: const Text('Cancelar'),
      hintText: 'Ingrese el tema a votar',
      minLines: 1,
      autoFocus: true,
      obscureText: false,
      textCapitalization: TextCapitalization.words,
    );
    if (result != null) {
      return Future.value(result);
    }
    return Future.error('cancel');
  }
}
