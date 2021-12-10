import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:red_maxanime/data/model/message_record.dart';

class chatController extends GetxController {
  final dbRef = FirebaseDatabase.instance.reference();
  var chats = <MessageRecord>[].obs;

  //metodo inicia controlador
  start() {
    chats.clear();
    dbRef.child('chats').onChildAdded.listen((event) {});
    dbRef.child('chats').onChildChanged.listen((event) {});
  }

  // metodo deterner el controlador
  stop() {
    dbRef.child('chats').onChildAdded.listen(newChat).cancel;
    dbRef.child('chats').onChildAdded.listen(editChat).cancel;
  }

  //nuevo mensaje
  newChat(Event event) {
    chats.add(MessageRecord.fromSnapshop(event.snapshot));
  }

  editChat(Event event) {
    var oldChat =
        chats.singleWhere((element) => element.key == event.snapshot.key);
    chats[chats.indexOf(oldChat)] = MessageRecord.fromSnapshop(event.snapshot);
  }

  // medtods enviar actualizar y eleiminar  msg
  Future<void> send(String text) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      dbRef.child('chats').push().set({'text': text, 'uid': uid});
      Future.value("enviado exitosamente!");
    } catch (e) {
      logError("Error: ${e.toString()}");
      Future.error("Error: ${e.toString()}");
    }
  }

  Future<void> edit(MessageRecord msg) async {
    try {
      dbRef
          .child('chats')
          .child(msg.key)
          .set({'text': msg.text, 'uid': msg.user});
      Future.value("actualizado exitosamente!");
    } catch (e) {
      logError("Error: ${e.toString()}");
      Future.error("Error: ${e.toString()}");
    }
  }

  Future<void> del(MessageRecord msg, int index) async {
    try {
      dbRef
          .child('chats')
          .child(msg.key)
          .remove()
          .then((value) => chats.remove(index));
      Future.value("eliminado correctamente!");
    } catch (e) {
      logError("Error: ${e.toString()}");
      Future.error("Error: ${e.toString()}");
    }
  }
}
