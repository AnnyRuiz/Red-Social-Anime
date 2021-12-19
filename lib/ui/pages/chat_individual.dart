import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:max_anime/domain/use_cases/controllers/authentication_controller.dart';
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

  void funcion(){

  }

  void sendMessage() async{
    if(messageController.text != '') {
      chats.sendMessage(widget.interaction_id, widget.listener_id, messageController.text).then((sala_id){
        if(widget.interaction_id == ''){
          widget.interaction_id = sala_id;
        }
      });
      messageController.clear();
    }
  }

  void guardarLastSeen(){
    if(widget.interaction_id != ''){
      chats.guardarLastSeen(widget.interaction_id);
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

    guardarLastSeen();
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


    final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
        .collection('mensajes').where(
        'sala_id', isEqualTo: widget.interaction_id).orderBy('date',descending: true).snapshots();

    final uid = AuthController.uid;

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
          Expanded(child: StreamBuilder<QuerySnapshot>(
            stream: _userStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError) {
                return Center(child:Text('Aun no hay mensajes'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                reverse: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Card(
                    margin: EdgeInsets.only(
                        top:10,
                        left: (data['user_id'] == uid) ? 80 : 10,
                        right: (data['user_id'] == uid) ? 10 : 80,
                        bottom: 10
                    ),
                    color: (data['user_id'] == uid) ? Color(0xff88c4a4) :Color(
                        0xffa8d0d7),//Color(0xffdff3f3),
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Text(data['mensaje'], style: TextStyle(color: Colors.black),),
                    ),
                  );
                }).toList(),
              );
            },
          ) ),
          enviarMensaje
        ],
      ),

    );
  }

}