import 'package:flutter/material.dart';

class ChatIndividual extends StatelessWidget{

  void funcionFloating(){

  }

  void funcion(){

  }

  String pathImage = 'assets/imags/profile';
  String nombre = 'Pepito';

  ChatIndividual(this.pathImage,this.nombre);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
                    image: AssetImage(pathImage)
                )
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 10
            ),
            child: Text(
              nombre,
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
                onPressed: funcion,
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