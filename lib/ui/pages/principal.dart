import 'package:flutter/material.dart';
import 'chats.dart';
import '../widges/app_drawer.dart';
import '../widges/bottom_bar.dart';
import 'feed.dart';
import 'notifications.dart';
import 'profile.dart';
import 'package:get/get.dart';
import 'package:max_anime/data/local/shared_prefs.dart';

class Principal extends StatefulWidget{

  //bool modoOscuro = false;
  //Principal({Key? key, required this.modoOscuro});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Principal();
  }

}

class _Principal extends State<Principal>{
  GlobalKey<ScaffoldState> _key = GlobalKey();

  int indexTap = 0;
  SharedPrefs prefs = SharedPrefs();
  bool modoOscuro = false;

  void getTema() async{
    await prefs.getTema().then((value) => {
      modoOscuro = value
    });
    setState(() {
      Get.changeThemeMode(
          modoOscuro ? ThemeMode.dark : ThemeMode.light
      );
    });
  }

  @override
  void initState(){
    super.initState();
    getTema();
  }

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
      modoOscuro = !modoOscuro;
      Get.changeThemeMode(
          modoOscuro ? ThemeMode.dark : ThemeMode.light
      );
    });
    prefs.setTema(modoOscuro);
  }

  @override
  Widget build(BuildContext context) {

    void paginaMensajes(){
      /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chats())
      );*/
      Get.toNamed('/chats');
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
                icon: modoOscuro ? Icon(Icons.wb_sunny) : Icon(Icons.nights_stay)
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.add),
        )
    );
  }

}