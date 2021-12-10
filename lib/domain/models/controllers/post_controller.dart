import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:red_maxanime/data/model/post_record.dart';

class PostController extends GetxController {
  final _posts = <PostRecord>[].obs;
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");
  final Stream<QuerySnapshot> _postsStream =
      FirebaseFirestore.instance.collection("posts").snapshots();

  late StreamSubscription<Object?> streamSubscription;
  //getters
  List<PostRecord> get entries => _posts;
  //metodo iniciar contesto conrolador
  subscribeUpdates() async {
    streamSubscription = _postsStream.listen((event) {
      _posts.clear();
      for (var elem in event.docs) {
        _posts.add(PostRecord.fromSnapshop(elem));
      }
    });
  }

  //finaliza metodo controlador
  unsubscribeUpdates() {
    streamSubscription.cancel();
  }

  //metod crear post
  addPost(title, content) {
    posts
        .add({'title': title, 'content': content, 'likes': 0})
        .then((value) => logInfo("Post creado exitosamente!"))
        .catchError((error) => logError("error al crear el post: $error"));
  }

  //metodo dar like eliminar
  giveLike(PostRecord post) {
    post.ref.update({'likes': post.likes + 1});
  }

  deletePost(PostRecord post) {
    post.ref.delete();
  }
}
