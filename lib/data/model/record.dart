import 'package:cloud_firestore/cloud_firestore.dart';

// Clase encargada de los registros
class Record {
  // Atributos
  final String name;
  final int votes;
  final DocumentReference reference;

  // Metodo que se encarga de convertir un mapa en un objeto de registros
  Record.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  // Metodo que se encarga de convertir un Documento de la base de datos
  // a un mapa de flutter
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  // Se sobre escribe el metodo de toString
  @override
  String toString() => "Record<$name:$votes>";
}
