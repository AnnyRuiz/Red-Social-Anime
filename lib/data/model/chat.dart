import 'package:cloud_firestore/cloud_firestore.dart';

// Clase encargada de los registrosde un char
class Chat {
  // Atributos
  final String text;
  final String user;
  final Timestamp date;
  final DocumentReference reference;

  // Metodo que se encarga de convertir un mapa en un objeto de registros
  Chat.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['text'] != null),
        assert(map['user'] != null),
        text = map['text'],
        user = map['user'],
        date = map['date'] ?? Timestamp.now();

  // Metodo que se encarga de convertir un Documento de la base de datos
  // a un mapa de flutter
  Chat.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  // Se sobre escribe el metodo de toString
  @override
  String toString() => "Chat<$user:$text>";
}
