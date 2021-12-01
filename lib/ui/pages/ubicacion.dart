import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widges/switch_button.dart';
import '../pages/chats_list.dart';

class Ubicacion extends StatelessWidget{

  String textoUbicacion = 'Barranquilla';

  Ubicacion(this.textoUbicacion);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Encontrar Personas'),
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 40
        ),
        child: Column(
          children: [
            Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: 10
                    ),
                    width: 120,
                    height: 120,
                    child: Image.asset(
                      'assets/imags/home.png',
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 40,
                          child:Text(
                            'Mi ubicación:',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          )),
                      Container(
                          height: 40,
                          child: Text(
                            textoUbicacion,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          )),
                    ],
                  )

                ]),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 20
              ),
                child:Row(
                  children: [
                    Text(
                      'Compartir mi ubicacion: ',
                      style: TextStyle(
                          fontSize: 22
                      ),
                    ),
                    SwitchButton(switchValue: false, funcion: (){})
                  ],
                )
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(
                top: 20,
                left: 10
              ),
              child: Text(
                'PERSONAS CERCA:'
              ),
            ),
            Expanded(child: ChatsList('cerca'))
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.place),
      ),
    );
  }

}