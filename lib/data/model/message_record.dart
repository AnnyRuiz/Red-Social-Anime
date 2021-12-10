import 'package:firebase_database/firebase_database.dart';

class MessageRecord {
  final String key;
  final String text;
  final String user;

  // metodo constructor
  MessageRecord(this.key, this.text, this.user);

  // metodo para deserealizar datos leidos en cloud
  MessageRecord.fromSnapshop(DataSnapshot snap)
      : key = snap.key ?? "0",
        text = snap.value["text"],
        user = snap.value["user"];

  // metodo json
  toJson() => {"text": text, "user": user};

  @override
  String toString() => "MessageRecord[key: $key, text: $text, user: $user]";
}
