import 'package:flutter/material.dart';
import 'chats.dart';
import '../widges/app_drawer.dart';
import '../widges/bottom_bar.dart';
import 'feed.dart';
import 'notifications.dart';
import 'profile.dart';
import 'package:get/get.dart';

class Principal extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Principal();
  }

}

class _Principal extends State<Principal>{
  GlobalKey<ScaffoldState> _key = GlobalKey();

  bool darkMode = false;
  int indexTap = 0;

  final List<Widget> widgetsChildren = [
    Feed(),
    Notifications(),
    Profile()
  ];

  void onTapTapped(int index){
    setState(() {
      indexTap = index;
    });
  }

  void cambiarTema(){
    setState(() {
      darkMode = !darkMode;
      Get.changeThemeMode(
          darkMode ? ThemeMode.dark : ThemeMode.light
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    void paginaMensajes(){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chats())
      );
    }

    void abrirDrawer(){
      _key.currentState!.openEndDrawer();
    }

    // TODO: implement build
    return Scaffold(
        key: _key,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
              'MaxAnime'
          ),

          actions: [
            IconButton(
                onPressed: cambiarTema,
                icon: darkMode ? Icon(Icons.wb_sunny) : Icon(Icons.nights_stay)
            ),
            IconButton(onPressed: paginaMensajes, icon: Icon(Icons.message)),
            IconButton(
                onPressed: abrirDrawer,
                icon: Icon(Icons.menu)
            ),

          ],
        ),

        body: widgetsChildren[indexTap],

        endDrawer: AppDrawer(false),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapTapped,
          currentIndex: indexTap,
          items: BottomBar().bottom_items(),
        )
    );
  }

}