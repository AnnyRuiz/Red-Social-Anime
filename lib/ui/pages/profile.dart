import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widges/post_list.dart';
import 'package:max_anime/domain/use_cases/controllers/profile_controller.dart';

class Profile extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _Profile();
  }

}

class _Profile extends State<Profile>{

  ProfileController profile = Get.find();

  void getData() async {
    bool retorno = false;
    await profile.loadData().then((value) =>
      retorno = value
    );
    setState(() {
      if(!retorno){
        print('maxanime: Ocurrio un error en profile get data');
      }
    });
  }

  void pickPhoto() async{
    bool done = false;
    await profile.uploadPhoto().then((value) => done = value);
    if(done){
      final snackBar = SnackBar(
        content: const Text('Foto actualizada correctamente'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      getData();
    }else{
      final snackBar = SnackBar(
        content: const Text('Ocurrio un error... Intentelo mas tarde'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

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
              image: NetworkImage(profile.pathImage)
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
      child: IconButton(onPressed: pickPhoto,icon: Icon(Icons.edit),),
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