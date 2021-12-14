import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Controlador encargado de la autenticacion de la aplicacion
class AuthenticationController extends GetxController {
  // Metodo encargado de crear una sesion de usuario en la aplicacion
  Future<void> login(theEmail, thePassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);
      // ignore: void_checks
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error("Usuario no encontrado!");
      } else if (e.code == 'wrong-password') {
        return Future.error("Contraseña incorrecta!");
      } else {
        return Future.error("Error: ${e.toString()}");
      }
    }
  }

  // Metodo encargado de crear un nuevo usuario en firebase
  Future<void> signUp(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // ignore: void_checks
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('La Contraseña no cumple con las politicas!');
      } else if (e.code == 'email-already-in-use') {
        return Future.error(
            'El Correo Electronico ya se encuentra registrado!');
      }
    }
  }

  // Metodo encargado de cerrar la sesion
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Metodo encargado de retornar el email del usuario conectado
  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }

  // Metodo encargado de retornar el identificador unico del usuario conectado
  String getUid() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
  }
}
