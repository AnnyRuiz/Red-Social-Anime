import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/chat_individual.dart';

class ChatRow extends StatefulWidget{

  String pathImage;
  String nombre;
  String ultima_conexion;
  bool chat_visto;
  String interaction_id;
  String listener_id;

  ChatRow({Key? key,
            required this.pathImage,
            required this.nombre,
            required this.ultima_conexion,
            required this.chat_visto,
            this.interaction_id='',
            required this.listener_id});

  @override
  State<StatefulWidget> createState() {
    return _ChatRow();
  }

}

class _ChatRow extends State<ChatRow>{

  void funcion(){
    if(Get.currentRoute == '/chats'){
      Get.to(ChatIndividual(
          pathImage: widget.pathImage,
          nombre: widget.nombre,
          interaction_id: widget.interaction_id,
          listener_id: widget.listener_id,
      ));
    }else{
      Get.off(ChatIndividual(
        pathImage: widget.pathImage,
        nombre: widget.nombre,
        interaction_id: widget.interaction_id,
        listener_id: widget.listener_id,
      ));
    }

  }

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
              image: NetworkImage(widget.pathImage)
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
              widget.nombre,
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
              'Activo ' + widget.ultima_conexion,
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
        color: widget.chat_visto ?  Colors.transparent :Color(0xFF1597a9),
      ),
    );

    return InkWell(
      onTap: funcion,
        child: Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: 12
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