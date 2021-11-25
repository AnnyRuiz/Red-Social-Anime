import 'package:flutter/material.dart';
import '../widges/chat_row.dart';

class ChatsList extends StatelessWidget{

  String area = 'principal';

  ChatsList(this.area);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final principal = ListView(
      children: [
        ChatRow('assets/imags/profile2.jpg', 'Ana', '5 minutos', false),
        ChatRow('assets/imags/profile.jpg', 'Dario', '10 minutos', true),
        ChatRow('assets/imags/profile.jpg', 'Alberto', '1 hora', false),
        ChatRow('assets/imags/profile2.jpg', 'Karen', '15 minutos', true),
      ],
    );

    final cerca = ListView(
      children: [
        ChatRow('assets/imags/profile.jpg', 'Johan', '5 minutos', false),
        ChatRow('assets/imags/profile2.jpg', 'Lina', '10 minutos', false),
      ],
    );

    if(area == 'principal'){
      return principal;
    }else{
      return cerca;
    }
  }

}