import 'package:cloud_firestore/cloud_firestore.dart';

class PostRecord {
  final String title;
  final String content;
  final int likes;
  final DocumentReference ref;

  //metodo para crear a traves de un documento de refrencias
  PostRecord.fromMap(Map<String, dynamic> map, {required this.ref})
      : assert(map['title'] != null),
        assert(map['content'] != null),
        assert(map['likes'] != null),
        title = map['title'],
        content = map['content'],
        likes = map['likes'];
  // metodo para desealizar datos leidos en cloud
  PostRecord.fromSnapshop(DocumentSnapshot snap)
      : this.fromMap(snap.data() as Map<String, dynamic>, ref: snap.reference);
  @override
  String toString() => "PostRecord[title: $title, likes: $likes]";
}
