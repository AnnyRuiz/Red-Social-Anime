import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_anime/ui/pages/chats_list.dart';
import '../widges/post_list.dart';
import 'package:max_anime/domain/use_cases/controllers/main_feed_controller.dart';
import 'package:get/get.dart';

class Feed extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Feed();
  }

}

class _Feed extends State<Feed>{

  MainFeedController feedController = Get.find();

  void getData() async {
    bool retorno = false;
    await feedController.getPosts().then((value) =>
    retorno = value
    );
    setState(() {
      print('maxanime: ${feedController.listPosts}');
      if(!retorno){
        print('Ocurrio un error en feed');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: ListView(
                children: feedController.listPosts,
              ),
      ),
    );
  }

}