import 'package:flutter/material.dart';
import 'package:max_anime/data/model/chat.dart';
import 'package:max_anime/domain/controller/authentication_controller.dart';
import 'package:max_anime/domain/controller/chats_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

// Widget para el manejo del Chat
class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  // Controlador para caja de texto
  late TextEditingController _controller;
  // Controlador para manejo de scroll
  late ScrollController _scrollController;
  // Inyeccion de controladores
  ChatsController chatController = Get.find();
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
  Widget _item(Chat element, int posicion, String uid) {
    logInfo('Usuario actual? -> ${uid == element.user} msg -> ${element.text}');
    return Card(
      margin: const EdgeInsets.all(4.0),
      color: uid == element.user ? Colors.yellow[200] : Colors.grey[300],
      child: ListTile(
        //onTap: () => chatController.updateMsg(element),
        //onLongPress: () => chatController.deleteMsg(element, posicion),
        title: Text(
          element.text,
          textAlign: uid == element.user ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }

  // Widget que se encarga de la creacion del listado
  Widget _list() {
    String uid = authenticationController.userEmail();
    logInfo('Id del usuario actual $uid');
    return GetX<ChatsController>(builder: (controller) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
      // Ordenar por fechas
      chatController.entries.sort((a, b) => a.date.compareTo(b.date));
      return ListView.builder(
        itemCount: chatController.entries.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          var element = chatController.entries[index];
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
