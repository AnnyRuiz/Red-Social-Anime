import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:max_anime/data/model/message.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

// Controlador encargado del chat interno de la aplicacion
class ChatController extends GetxController {
  // Creacion de una nueva instancia de Base de datos
  final databaseReference = FirebaseDatabase.instance.reference();
  // Variable reactiva
  var messages = <Message>[].obs;
  // Atributos para manejo de eventos del controlador
  late StreamSubscription<Event> newEntryStreamSubscription;
  late StreamSubscription<Event> updateEntryStreamSubscription;

  // Metodo para iniciar la escucha de los eventos realizado por
  // el controlador
  start() {
    messages.clear();
    newEntryStreamSubscription = databaseReference
        .child("fluttermessages")
        .onChildAdded
        .listen(_onEntryAdded);

    updateEntryStreamSubscription = databaseReference
        .child("fluttermessages")
        .onChildChanged
        .listen(_onEntryChanged);
  }

  // Metodo para detener la escucha de los eventos realizado por
  // el controlador
  stop() {
    newEntryStreamSubscription.cancel();
    updateEntryStreamSubscription.cancel();
  }

  // Evento encargado de verificar las actualizaciones mensajes
  _onEntryChanged(Event event) {
    logInfo("Un Mensaje ha cambiado!");
    var oldEntry = messages.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    messages[messages.indexOf(oldEntry)] = Message.fromSnapshot(event.snapshot);
  }

  // Evento encargado de verificar los nuevos mensajes
  _onEntryAdded(Event event) {
    logInfo("Un Mensaje ha sido agregado!");
    messages.add(Message.fromSnapshot(event.snapshot));
  }

  // Metodo encargado de enviar un mensaje
  Future<void> sendMsg(String text) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      databaseReference
          .child("fluttermessages")
          .push()
          .set({'text': text, 'uid': uid});
    } catch (error) {
      logError("Error al enviar un mensaje: $error");
      return Future.error(error);
    }
  }

  // Metodo para actualizar un mensaje
  Future<void> updateMsg(Message message) async {
    logInfo('Actualizando mensaje con la llave ${message.key}');
    try {
      databaseReference
          .child("fluttermessages")
          .child(message.key)
          .set({'text': 'updated ' + message.text, 'uid': message.user});
    } catch (error) {
      logError("Error updating msg $error");
      return Future.error(error);
    }
  }

  // Metodo para eliminar un mensaje
  Future<void> deleteMsg(Message message, int index) async {
    logInfo('Eliminando mensaje con llave ${message.key}');
    try {
      databaseReference
          .child("fluttermessages")
          .child(message.key)
          .remove()
          .then((value) => messages.removeAt(index));
    } catch (error) {
      logError("Error deleting msg $error");
      return Future.error(error);
    }
  }
}