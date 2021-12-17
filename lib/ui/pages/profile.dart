import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widges/post_list.dart';
import 'package:max_anime/domain/use_cases/controllers/profile_controller.dart';

class Profile extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile();
  }

}

class _Profile extends State<Profile>{

  String pathImage = 'assets/imags/profile.jpg';
  String nombre = '';
  String email = '';
  ProfileController profile = Get.find();

  void getData() async {
    bool retorno = false;
    await profile.loadData().then((value) =>
      retorno = value
    );
    setState(() {
      if(!retorno){
        print('Ocurrio un error');
      }
    });
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final photo = Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.only(
        right: 15
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit:BoxFit.cover,
              image: AssetImage(pathImage)
          )
      ),
    );

    final datos = Expanded(
      child: Container(
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${profile.nombre}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21
              ),
            ),
            Text(
                '${profile.email}',
                style: TextStyle(
                    fontSize: 15
                )
            )
          ],
        ),
      )
    );

    final edit = Container(
      height: 80,
      width: 50,
      alignment: Alignment.center,
      child: Icon(Icons.edit),
    );

    final userData = Container(
      height: 100,
      margin: EdgeInsets.all(25),
      child: Row(
        children: [
          photo,
          datos,
          edit
        ],
      ),
    );

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            userData,
            Expanded(
              child: ListView(
                children: profile.listPosts,
              ),
            )
          ],
        ),
      ),
    );
  }

}