import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController{

  var _mensaje = ''.obs;
  var _mensajeReg = ''.obs;

  String get mensaje => _mensaje.value;
  String get mensajeReg => _mensajeReg.value;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String uid = '';

  Future<bool> signIn(email,pass) async{
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
        password: pass
      );
      print('maxanime: credencial de usuario tras login' + '${userCredential}');
      getUid();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _mensaje.value = 'Usuario no encontrado';
      } else if (e.code == 'wrong-password') {
        _mensaje.value = 'Constraseña incorrecta';
      }else{
        _mensaje.value = 'Usuario o contraseña erroneos';
      }
      return false;
    }

  }

  Future<bool> signUp(user, name, last_name, email,pass) async{
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: pass,
      );
      print('maxanime: ${userCredential}');

      var currentUser = auth.currentUser;
      //TODO: VALIDAR QUE EL USER SEA UNICO
      if (currentUser != null) {
        CollectionReference users = firestore.collection('users');
        await users
            .doc(currentUser.uid)
            .set({
          'user': user,
          'name': name,
          'last_name': last_name,
          'email': email
        }).then((value) => print("User Added"));
      }
      getUid();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _mensajeReg.value = 'La contraseña es muy debil';
      } else if (e.code == 'email-already-in-use') {
        _mensajeReg.value = 'La cuenta para el email dado ya existe';
      }
      return false;
    } catch (e) {
      print(e);
      _mensajeReg.value = 'Ocurrio un error intentelo mas tarde';
      return false;
    }
  }

  Future<bool> signOut() async{
    try {
      await auth.signOut();
      getUid();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void getUid(){
    var currentUser = auth.currentUser;
    if (currentUser != null) {
      uid = currentUser.uid;
    }else{
      uid = '';
    }
    print('maxanime: uid es $uid');
  }

}