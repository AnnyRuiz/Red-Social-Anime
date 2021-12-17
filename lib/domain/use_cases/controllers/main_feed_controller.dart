import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:max_anime/ui/widges/post.dart';

class MainFeedController extends GetxController{

  var _listPosts = [Post(nombre: '', pathImage: '', contenido: '')].obs;
  var _nombre = ''.obs;
  List<Post> get listPosts => _listPosts;
  String get nombre => _nombre.value;
  Future<bool> getPosts() async{
    _listPosts.clear();
    try{
      CollectionReference posts = await FirebaseFirestore.instance.collection('posts');
      CollectionReference users = await FirebaseFirestore.instance.collection('users');
      String uid = '';
      String userName = '';
      String pathImage = '';
      await posts.get()
          .then((QuerySnapshot querySnapshot){
            querySnapshot.docs.forEach((docu) async{
              uid = docu['user_id'];
              await users.doc(uid).get()
                  .then((DocumentSnapshot snapshot){
                    if(snapshot.exists){
                      userName = snapshot.get('user');
                      //pathImage = snapshot.get('path_image');
                    }
                  });
              //print('maxanime: los posts son: ${doc.data()}');
              print('maxanime: los valores de la lista de posts en feed es: $userName $pathImage');
              _listPosts.add(Post(nombre: userName, pathImage: 'pathImage', contenido: docu['content']));
              //print('maxanime: la lista de posts en feed es: $_listPosts');
        });
      });
      //print('maxanime: la lista de posts en feed es 2: $_listPosts');
      _nombre.value = 'no';
      return true;
    }catch(e){
      print('maxanime: error en feed posts $e');
      return false;
    }
  }
}