import 'package:flutter/material.dart';
import 'package:max_anime/domain/use_cases/controllers/chats_controller.dart';
import 'package:get/get.dart';

class NewConversation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewConversation();
  }

}

class _NewConversation extends State<NewConversation>{

  ChatsController chatControl = Get.find();

  void nuevoChat() async{
    bool retorno = false;
    await chatControl.newConversation().then((value) =>
      retorno = value
    );
    setState(() {
      //print('maxanime: ${feedController.listPosts}');
      if(!retorno){
        print('maxanime: Ocurrio un error en chats newChat');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nuevoChat();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Chat'),
      ),
      body: ListView(
        children: chatControl.listUsers,
      ),
    );
  }

}