import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:red_max_anime/data/model/chat.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

// Controlador encargado del chat interno de la aplicacion
class ChatsController extends GetxController {
  // Variable reactiva
  final _records = <Chat>[].obs;
  // Instancia de base de datos
  final CollectionReference chats =
      FirebaseFirestore.instance.collection('chats');
  // Instancia de manejo de base de datos
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('chats').snapshots();
  // Subscripcion cambio de objetos
  late StreamSubscription<Object?> streamSubscription;
  // Getters
  List<Chat> get entries => _records;

  // Metodo para iniciar la escucha de los eventos realizado por
  // el controlador
  start() {
    logInfo('Inicio de subscripciones');
    streamSubscription = _usersStream.listen((event) {
      logInfo('Se obtuvo un nuevo registro de fireStore');
      _records.clear();
      for (var element in event.docs) {
        _records.add(Chat.fromSnapshot(element));
      }
      logInfo('Se obtuvieron ${_records.length} registros');
    });
  }

  // Metodo para detener la escucha de los eventos realizado por
  // el controlador
  stop() {
    streamSubscription.cancel();
  }

  addEntry(text, user) {
    chats
        .add({'text': text, 'user': user})
        .then((value) => logInfo("Mensaje adicionado"))
        .catchError((onError) =>
            logError("Fallo al agregar un nuevo mensaje $onError"));
  }

  // Metodo encargado de enviar un mensaje
  Future<void> sendMsg(String text) async {
    String? user = FirebaseAuth.instance.currentUser!.email;
    try {
      chats
          .add({'text': text, 'user': user, 'date': DateTime.now()})
          .then((value) => logInfo("Mensaje adicionado"))
          .catchError((onError) =>
              logError("Fallo al agregar un nuevo mensaje $onError"));
    } catch (error) {
      logError("Error al enviar un mensaje: $error");
      return Future.error(error);
    }
  }
}
