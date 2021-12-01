import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chats_list.dart';
import 'package:get/get.dart';

class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Chats();
  }

}

class _Chats extends State<Chats>{

  void funcion(){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return //MaterialApp(
      //theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      //home:

      Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'PRINCIPAL'),
                Tab(text: 'CERCA DE TI',)
              ],
            ),
            title: const Text('Chats'),
            actions: [
              IconButton(onPressed: funcion, icon: Icon(Icons.search)),
              IconButton(onPressed: funcion, icon: Icon(Icons.more_vert))
            ],
          ),
          body: TabBarView(
            children: [
              ChatsList('principal'),
              ChatsList('cerca')
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: funcion,
            child: const Icon(Icons.question_answer),
          ),
        ),
      ),
    );

  }
  
}