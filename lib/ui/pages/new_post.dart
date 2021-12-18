import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_anime/domain/use_cases/controllers/main_feed_controller.dart';

class NewPost extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewPost();
  }

}

class _NewPost extends State<NewPost>{

  MainFeedController feedController = Get.find();
  final textController = TextEditingController();

  void publish() async{
    bool result = false;
    await feedController.publisPost(textController.text)
        .then((value) => result = value);
    if(result){
      final snackBar = SnackBar(
        content: const Text('Post creado correctamente'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.offNamed('/principal');
    }else{
      final snackBar = SnackBar(
        content: const Text('Ocurrio un error... Intentalo mas tarde'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Post'),
        actions: [
          IconButton(onPressed: publish, icon: Icon(Icons.cloud_upload))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
          child: TextField(
            controller: textController,
            maxLines: 25,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Que quieres compartir?',
              border: InputBorder.none
            ),
          ),
      )

    );
  }

}