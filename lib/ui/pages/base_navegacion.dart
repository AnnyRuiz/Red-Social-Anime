import 'package:flutter/material.dart';
import 'chats.dart';

class BaseNavegacion extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void paginaMensajes(){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chats())
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'MaxAnime'
        ),
        actions: [
          IconButton(onPressed: paginaMensajes, icon: Icon(Icons.message)),
          IconButton(onPressed: paginaMensajes, icon: Icon(Icons.menu))
        ],
      ),
      body: Row(),
    );
  }

}