import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/ubicacion.dart';
import '../widges/switch_button.dart';

class AppDrawer extends StatefulWidget{

  bool switchOscuro = false;
  bool switchUbicacion = false;

  AppDrawer(this.switchOscuro, this.switchUbicacion);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppDrawer(switchOscuro,switchUbicacion);
  }

}

class _AppDrawer extends State<AppDrawer>{

  bool _switchOscuro = false;
  bool _switchUbicacion = false;

  _AppDrawer(this._switchOscuro, this._switchUbicacion);

  @override
  Widget build(BuildContext context) {

    void abrirUbicacion(){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ubicacion('Barranquilla'))
      );
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
                color: Color(0xFFA54515)
              ),
            ),

          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                    child: Text(
                      'Modo oscuro',
                      style: TextStyle(
                          fontSize: 15
                      ),
                    )),
                SwitchButton(_switchOscuro)
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                    child: Text(
                      'Ubicación',
                      style: TextStyle(
                          fontSize: 15
                      ),
                    )),
                SwitchButton(_switchUbicacion)
              ],
            ),
          )
        ],
      ),
    );
  }

}