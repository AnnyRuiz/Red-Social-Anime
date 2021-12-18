import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:max_anime/ui/widges/post.dart';

import 'authentication_controller.dart';

class MainFeedController extends GetxController{

  var _listPosts = [Post(nombre: '', pathImage: '', contenido: '')].obs;

  List<Post> get listPosts => _listPosts;
  
  List<Map> postsData = [];

  Future<bool> getPosts() async{
    _listPosts.clear();
    postsData.clear();
    try{

      CollectionReference posts = await FirebaseFirestore.instance.collection('posts');
      CollectionReference users = await FirebaseFirestore.instance.collection('users');

      await posts.orderBy('uploaded',descending: true).get()
          .then((QuerySnapshot querySnapshot){
            querySnapshot.docs.forEach((docu) async{
              postsData.add({'user_id':docu['user_id'], 'content':docu['content'], 'likes': docu['likes']});
        });
      });

      for(final post in postsData){

        String uid = post['user_id'];

        await users.doc(uid).get()
            .then((DocumentSnapshot snapshot){
          if(snapshot.exists){
            post['user'] = snapshot['user'];
            post['path_image'] = snapshot.get('path_image');
            print('maxanime: los valores de la lista de posts en feed es: ${post['user']} ${post['path_image']}');
          }
        });

        _listPosts.add(Post(nombre: post['user'], pathImage: post['path_image'], contenido: post['content']));

      }

      print('maxanime: la lista de posts en feed es 2: $postsData');
      return true;

    }catch(e){
      print('maxanime: error en feed posts $e');
      return false;
    }
  }

  Future<bool> publisPost(content) async{
    CollectionReference posts = await FirebaseFirestore.instance.collection('posts');
    String uid = AuthController.uid;
    bool response = false;
    await posts.add({
      'content': content,
      'likes': 0,
      'uploaded': DateTime.now(),
      'user_id': uid
    })
        .then((value) =>
          response = true
        )
        .catchError((error) => {
          print(error),
          response = false
        }
        );
    return response;
  }
}