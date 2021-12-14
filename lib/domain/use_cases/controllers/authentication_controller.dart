import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController{

  var _mensaje = ''.obs;

  String get mensaje => _mensaje.value;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signIn(email,pass) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass
      );
      print('maxanime'+'retornando bien');
      print('maxanime' + '${userCredential}');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _mensaje.value = 'Usuario incorrecto para el email dado';
      } else if (e.code == 'wrong-password') {
        _mensaje.value = 'Constraseña incorrecta';
      }else{
        _mensaje.value = 'Usuario o contraseña erroneos';
      }
      print('maxanime'+'retornando mal');
      return false;
    }

  }




}