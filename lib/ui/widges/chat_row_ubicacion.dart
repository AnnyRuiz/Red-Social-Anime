import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/chat_individual.dart';

class ChatRowUbicacion extends StatefulWidget{

  String pathImage = 'assets/imags/profile.jpg';
  String nombre = 'Pepito';
  String distancia = "1Km";

  ChatRowUbicacion(this.pathImage, this.nombre, this.distancia);

  @override
  State<StatefulWidget> createState() {
    return _ChatRowUbicacion(pathImage,nombre,distancia);
  }

}

class _ChatRowUbicacion extends State<ChatRowUbicacion>{

  void funcion(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatIndividual(pathImage: pathImage, nombre: nombre, interaction_id: '', listener_id: '',))
    );
  }

  String pathImage = 'assets/imags/profile.jpg';
  String nombre = 'Pepito';
  String distancia = "1Km";

  _ChatRowUbicacion(this.pathImage, this.nombre, this.distancia);

  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final photo = Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit:BoxFit.cover,
              image: AssetImage(pathImage)
          )
      ),
    );

    final info = Container(
      height: 80,
      width: queryData.size.width - 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(
              left: 20,
            ),
            height: 40,
            child: Text(
              nombre,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  left: 20
              ),
              height: 30,
              child: Text(
                'A ' + distancia,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                ),
              )
          )
        ],
      ),
    );

    return InkWell(
        onTap: funcion,
        child: Container(
          margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 25
          ),
          child: Row(
            children: [
              photo,
              info
            ],
          ),
        )
    );
  }

}