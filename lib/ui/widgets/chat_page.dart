import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:max_anime/data/model/message.dart';
import 'package:max_anime/domain/controller/authentication_controller.dart';
import 'package:max_anime/domain/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

final databaseReference = FirebaseDatabase.instance.reference();

// Widget para el manejo del Chat
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Controlador para caja de texto
  late TextEditingController _controller;
  // Controlador para manejo de scroll
  late ScrollController _scrollController;
  // Inyeccion de controladores
  ChatController chatController = Get.find();
  AuthenticationController authenticationController = Get.find();

  // Se altera el ciclo vida del Widget para el inicio
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
    chatController.start();
  }

  // Se altera el ciclo vida del Widget para la destruccion
  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    chatController.stop();
    super.dispose();
  }

  // Widget que se encarga de mostrar los mensajes
  Widget _item(Message element, int posicion, String uid) {
    logInfo('Usuario actual? -> ${uid == element.user} msg -> ${element.text}');
    return Card(
      margin: const EdgeInsets.all(4.0),
      color: uid == element.user ? Colors.yellow[200] : Colors.grey[300],
      child: ListTile(
        onTap: () => chatController.updateMsg(element),
        onLongPress: () => chatController.deleteMsg(element, posicion),
        title: Text(
          element.text,
          textAlign: uid == element.user ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }

  // Widget que se encarga de la creacion del listado
  Widget _list() {
    String uid = authenticationController.getUid();
    logInfo('Id del usuario actual $uid');
    return GetX<ChatController>(builder: (controller) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
      return ListView.builder(
        itemCount: chatController.messages.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          var element = chatController.messages[index];
          return _item(element, index, uid);
        },
      );
    });
  }

  // Metodo que se encarga de enviar el mensaje
  Future<void> _sendMsg(String text) async {
    logInfo("Enviando el mensaje $text");
    await chatController.sendMsg(text);
  }

  // Widget que se encarga del envio del mensaje
  Widget _textInput() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, top: 5.0),
            child: TextField(
              key: const Key('MsgTextField'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Escribir Mensaje',
              ),
              onSubmitted: (value) {
                _sendMsg(_controller.text);
                _controller.clear();
              },
              controller: _controller,
            ),
          ),
        ),
        TextButton(
          key: const Key('sendButton'),
          child: const Text('Enviar'),
          onPressed: () {
            _sendMsg(_controller.text);
            _controller.clear();
          },
        ),
      ],
    );
  }

  // Metodo encargado de la animacion del scroll
  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
    return Column(
      children: [Expanded(flex: 4, child: _list()), _textInput()],
    );
  }
}