import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chats_list.dart';

class Chats extends StatelessWidget{

  void funcion(){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
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