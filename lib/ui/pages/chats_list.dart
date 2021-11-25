import 'package:flutter/material.dart';
import 'package:max_anime/ui/widges/chat_row_ubicacion.dart';
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
        ChatRowUbicacion('assets/imags/profile.jpg', 'Johan', '1 Km'),
        ChatRowUbicacion('assets/imags/profile2.jpg', 'Lina', '200 metros'),
        ChatRowUbicacion('assets/imags/profile.jpg', 'Julio', '2 Km'),
        ChatRowUbicacion('assets/imags/profile2.jpg', 'Lorena', '100 metros'),
        ChatRowUbicacion('assets/imags/profile.jpg', 'Oscar', '3 Km'),
        ChatRowUbicacion('assets/imags/profile2.jpg', 'Laura', '1 Km'),
        ChatRowUbicacion('assets/imags/profile.jpg', 'Duvan', '500 metros'),
        ChatRowUbicacion('assets/imags/profile2.jpg', 'Angie', '100 metros'),
      ],
    );

    if(area == 'principal'){
      return principal;
    }else{
      return cerca;
    }
  }

}