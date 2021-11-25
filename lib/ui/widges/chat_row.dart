import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/chat_individual.dart';

class ChatRow extends StatefulWidget{

  String pathImage = 'assets/imags/profile.jpg';
  String nombre = 'Pepito';
  String ultima_conexion = "Activo hace 10 minutos";
  bool nuevo_chat = false;

  ChatRow(this.pathImage, this.nombre, this.ultima_conexion, this.nuevo_chat);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatRow(pathImage,nombre,ultima_conexion,nuevo_chat);
  }

}

class _ChatRow extends State<ChatRow>{

  void funcion(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatIndividual(pathImage, nombre))
    );
  }

  String pathImage = 'assets/imags/profile.jpg';
  String nombre = 'Pepito';
  String ultima_conexion = "Activo hace 10 minutos";
  bool nuevo_chat = false;

  _ChatRow(this.pathImage, this.nombre, this.ultima_conexion, this.nuevo_chat);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
              'Activo hace ' + ultima_conexion,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
              ),
            )
          )
        ],
      ),
    );

    final nuevos = Container(
      alignment: Alignment.center,
      height: 80,
      child: Icon(
        Icons.circle,
        color: this.nuevo_chat ? Color(0xFF1597a9) : Colors.transparent,
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
              info,
              nuevos
            ],
          ),
        )
    );
  }

}