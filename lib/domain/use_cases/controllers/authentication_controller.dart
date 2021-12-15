import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController{

  var _mensaje = ''.obs;
  var _mensajeReg = ''.obs;

  String get mensaje => _mensaje.value;
  String get mensajeReg => _mensajeReg.value;

  FirebaseAuth auth = FirebaseAuth.instance;


  Future<bool> signIn(email,pass) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
        password: pass
      );
      print('maxanime: credencial de usuario tras login' + '${userCredential}');
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

  Future<bool> signUp(email,pass) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _mensajeReg.value = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        _mensajeReg.value = 'The account already exists for that email.';
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
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


}