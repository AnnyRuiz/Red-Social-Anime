import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Post extends StatefulWidget{

  String pathImage;
  String nombre;
  String contenido;

  Post({Key? key, required this.nombre, required this.pathImage, required this.contenido});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Post();
  }

}

class _Post extends State<Post>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double screenWidth = MediaQuery.of(context).size.width;

    final photo = Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.only(
          right: 15
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit:BoxFit.cover,
              image: AssetImage(widget.pathImage)
          )
      ),
    );

    final postData = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.nombre,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          child: Text(
            widget.contenido,
            style: TextStyle(
              height: 1.4
            ),
          ),
        )
      ],
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.grey)
        )
      ),
      padding: EdgeInsets.only(
        top: 30,
        left: 25,
        right: 25,
        bottom: 20
      ),
      width: screenWidth - 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          photo,
          Expanded(child: postData)
        ],
      ),

    );
  }

}