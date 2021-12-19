import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_anime/domain/use_cases/controllers/chats_controller.dart';

class ChatIndividual extends StatefulWidget{

  String pathImage;
  String nombre;
  String interaction_id;
  String listener_id;

  ChatIndividual({Key ? key,
    required this.pathImage,
    required this.nombre,
    required this.interaction_id,
    required this.listener_id});

  @override
  State<StatefulWidget> createState() {
    return _ChatIndividual();
  }

}

class _ChatIndividual extends State<ChatIndividual>{

  ChatsController chats = Get.find();
  TextEditingController messageController = TextEditingController();

  void funcionFloating(){

  }

  void funcion(){

  }

  void sendMessage() async{
    if(messageController.text != '') {
      chats.sendMessage(widget.interaction_id, widget.listener_id);
    }
  }

  void getMensajes(){
    //TODO: logica para obtener mensajes
  }


  @override
  void initState() {
    super.initState();
    if(widget.interaction_id != ''){
      getMensajes();
    }
  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final appbarPersonalizado = Row(
        children:[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit:BoxFit.cover,
                    image: NetworkImage(widget.pathImage)
                )
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 10
            ),
            child: Text(
              widget.nombre,
            ),
          )
        ]
    );

    final enviarMensaje = Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: queryData.size.width - 90,
              height: 60,
              margin: EdgeInsets.only(
                right: 10
              ),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe tu mensaje...'
                ),
              ),
            ),
            Container(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                onPressed: sendMessage,
                child: const Icon(Icons.send),
              ),
            )
          ],
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: appbarPersonalizado,
        actions: [
          IconButton(onPressed: funcion, icon: Icon(Icons.search)),
          IconButton(onPressed: funcion, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          enviarMensaje
        ],
      ),

    );
  }

}