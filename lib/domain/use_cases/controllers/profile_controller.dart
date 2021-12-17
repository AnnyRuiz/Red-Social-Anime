import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:max_anime/domain/use_cases/controllers/authentication_controller.dart';
import 'package:max_anime/ui/widges/post.dart';

class ProfileController extends GetxController{

  var _nombre = ''.obs;
  var _email = ''.obs;
  var _pathImage = 'assets/imags/profile.jpg'.obs;
  var _userName = ''.obs;
  var _listPosts = [Post(nombre: '', pathImage: '', contenido: '')].obs;

  String get userName => _userName.value;
  String get nombre => _nombre.value;
  String get email => _email.value;
  String get pathImage => _pathImage.value;
  List<Post> get listPosts => _listPosts;

  Future<bool> loadData() async{
    try{
      String uid = AuthController.uid;
      print('maxanime: en profile el uid es $uid');
      CollectionReference users = await FirebaseFirestore.instance.collection('users');
      await users.doc(uid).get()
          .then((DocumentSnapshot snapshot){
              if(snapshot.exists){
                _nombre.value = '${snapshot.get('name')} ${snapshot.get('last_name')}';
                _email.value = snapshot.get('email');
                _userName.value = snapshot.get('user');
                _pathImage.value = snapshot.get('path_image');
              }
          });
      return getPosts();
    }catch(e){
      print('maxanime: error en profile ${e}');
      return false;
    }

  }

  Future<bool> getPosts() async{
    String uid = AuthController.uid;
    _listPosts.clear();
    try{
      CollectionReference posts = await FirebaseFirestore.instance.collection('posts');
      await posts.get()
          .then((QuerySnapshot snapshot){
            snapshot.docs.forEach((doc) {
              if(doc['user_id'] == uid){
                print('maxanime: los posts son: ${doc.data()}');
                _listPosts.add(Post(nombre: userName, pathImage: pathImage, contenido: doc['content']));
              }
            });
      });
      return true;
    }catch(e){
      print('maxanime: error en profile posts $e');
      return false;
    }
  }
}