import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_anime/domain/use_cases/controllers/authentication_controller.dart';
import '../pages/ubicacion.dart';
import '../widges/switch_button.dart';
import 'package:get/get.dart';

class AppDrawer extends StatefulWidget{

  bool switchUbicacion = false;

  AppDrawer(this.switchUbicacion);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppDrawer(switchUbicacion);
  }

}

class _AppDrawer extends State<AppDrawer>{

  bool _switchUbicacion = false;

  _AppDrawer(this._switchUbicacion);

  AuthController authController = Get.find();

  void signOut() async{
    bool correctUser = false;
    await authController.signOut().then((value) => {
      correctUser = value
    });
    if(correctUser) {
      final snackBar = SnackBar(
        content: const Text('Sesion cerrada correctamente'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.offNamed('/login');
    }else{
      final snackBar = SnackBar(
        content: const Text('Ocurrio un error!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {

    void abrirUbicacion(){
      /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ubicacion('Barranquilla'))
      );*/
      Get.toNamed('/ubicacion');
    }
    
    void cambiarUbicacion(){
      
    }
    
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(30),
        children: [
          DrawerHeader(
              child: Center(
                child: Text(
                  'MaxAnime',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )),
          ListTile(
            onTap: abrirUbicacion,
            title: const Text(
              'Encontrar personas cerca',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                    child: Text(
                      'Ubicación',
                      style: TextStyle(
                          fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SwitchButton(
                    switchValue: _switchUbicacion,
                    funcion: cambiarUbicacion
                )
              ],
            ),
          ),
          ListTile(
            onTap: signOut,
            title: const Text(
              'Sing Out',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),

          )
        ],
      ),
    );
  }

}