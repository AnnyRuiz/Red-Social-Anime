import 'package:cloud_firestore/cloud_firestore.dart';

// Clase que representa la entidad Persona
class Persona {
  // Atributos
  final String nomb;
  // Auditoria
  late String usua;
  late Timestamp fecha;
  // Documento de Referencia en Firestore [Obligatorio]
  late DocumentReference reference;

  // Constructor
  Persona(this.nomb);

  // Metodo que se encarga de convertir un mapa en un objeto de registros [Obligatorio]
  Persona.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['nomb'] != null),
        assert(map['usua'] != null),
        nomb = map['nomb'],
        usua = map['usua'],
        fecha = map['fecha'];

  // Metodo que se encarga de convertir un Documento de la base de datos
  // a un mapa de flutter [Obligatorio]
  Persona.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  // Metodo para serializar a JSON
  toJson(String? usuario) {
    return {
      'nomb': nomb,
      'usua': usuario,
      'fecha': Timestamp.now(),
    };
  }

  // Se sobre escribe el metodo de toString
  @override
  String toString() => "Post<$nomb>";
}
