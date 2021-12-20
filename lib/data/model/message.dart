import 'package:firebase_database/firebase_database.dart';

// Clase encargada de los mensajes
class Message {
  // Atributos
  String key;
  String text;
  String user;

  // Constructor
  Message(this.key, this.text, this.user);

  // Metodo para convertir datos obtenidos de la base de datos a
  // un objeto de tipo Mensaje
  Message.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key ?? "0",
        text = snapshot.value["text"],
        user = snapshot.value["uid"];

  // Metodo que convierte objeto en una representacion JSON
  toJson() {
    return {
      "text": text,
      "user": user,
    };
  }
}