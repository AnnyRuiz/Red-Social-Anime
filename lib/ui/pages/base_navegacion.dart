import 'package:flutter/material.dart';
import 'chats.dart';
import '../widges/app_drawer.dart';

class BaseNavegacion extends StatelessWidget{
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void paginaMensajes(){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chats())
      );
    }

    void abrirDrawer(){
      _key.currentState!.openEndDrawer();
    }

    return MaterialApp(
        home:Scaffold(
          key: _key,

          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                'MaxAnime'
            ),

            actions: [
              IconButton(onPressed: paginaMensajes, icon: Icon(Icons.message)),
              IconButton(
                  onPressed: abrirDrawer,
                  icon: Icon(Icons.menu)
              )
            ],
          ),

          body: Row(),

          endDrawer: AppDrawer(false, true),
        )
    );
  }

}