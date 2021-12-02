import 'package:flutter/material.dart';
import 'post.dart';


class PostList extends StatelessWidget{

  String area = 'feed';

  PostList(this.area);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final feed = ListView(
      children: [
        Post(nombre: 'Eduardo Avendaño', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Laura Bello', pathImage: 'assets/imags/profile2.jpg', contenido: '🤩 Recien compre la saga de GitiX ... Estoy emocionada'),
        Post(nombre: 'Eduardo Avendaño', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Laura Bello', pathImage: 'assets/imags/profile2.jpg', contenido: '🤩 Recien compre la saga de GitiX ... Estoy emocionada'),
        Post(nombre: 'Eduardo Avendaño', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Laura Bello', pathImage: 'assets/imags/profile2.jpg', contenido: '🤩 Recien compre la saga de GitiX ... Estoy emocionada'),
        Post(nombre: 'Eduardo Avendaño', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Laura Bello', pathImage: 'assets/imags/profile2.jpg', contenido: '🤩 Recien compre la saga de GitiX ... Estoy emocionada'),

      ],
    );

    final profile = ListView(
      children: [
        Post(nombre: 'Eduardo Jimenez', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Eduardo Jimenez', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Eduardo Jimenez', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Eduardo Jimenez', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Eduardo Jimenez', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Eduardo Jimenez', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),
        Post(nombre: 'Eduardo Jimenez', pathImage: 'assets/imags/profile.jpg', contenido: 'El primer capitulo de Arcane ... simplemente 🤯'),

      ],
    );

    if(area == 'feed'){
      return feed;
    }else{
      return profile;
    }
  }

}