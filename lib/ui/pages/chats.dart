import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chats_list.dart';
import 'package:get/get.dart';
import 'package:max_anime/domain/use_cases/controllers/chats_controller.dart';

class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Chats();
  }

}

class _Chats extends State<Chats>{

  ChatsController chatControl = Get.find();

  void funcion(){

  }

  void funcionMas(value){
    switch(value){
      case 'actualizar':
        getChats();
        break;
    }
  }

  void newConversation(){
    Get.toNamed('/new_chat');
    deactivate();
  }

  void getChats() async {
    bool retorno = false;
    await chatControl.getSalas().then((value) =>
      retorno = value
    );
    setState(() {
      print('maxanime: si entre a set state');
      if(!retorno){
        print('maxanime: Ocurrio un error en chats getChats');
      }
    });
    chatControl.actualizarUltimaConexion();
  }

  @override
  void initState() {
    // TODO: actualizar ultima conexion
    super.initState();
    getChats();
  }

  @override
  Widget build(BuildContext context) {
    return //MaterialApp(
      //theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      //home:

      Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'PRINCIPAL'),
                Tab(text: 'CERCA DE TI',)
              ],
            ),
            title: const Text('Chats'),
            actions: [
              IconButton(onPressed: funcion, icon: Icon(Icons.search)),
              PopupMenuButton(
                itemBuilder: (BuildContext context) =>[
                  PopupMenuItem(child: Text('Actualizar'), value: 'actualizar',)
                ],
                onSelected: funcionMas,
              ),

            ],
          ),
          body: TabBarView(
            children: [
              ListView(
                children: chatControl.listChats,
              ),
              ChatsList('cerca')
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: newConversation,
            child: const Icon(Icons.question_answer),
          ),
        ),
      ),
    );

  }
  
}