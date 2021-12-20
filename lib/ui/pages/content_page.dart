import 'package:flutter/material.dart';
import 'package:red_max_anime/domain/controller/authentication_controller.dart';
import 'package:red_max_anime/ui/pages/stateful/gps_page.dart';
import 'package:get/get.dart';
import 'package:red_max_anime/domain/use_case/controllers/theme_controller.dart';
import 'package:red_max_anime/ui/widgets/appbar.dart';

import '../widgets/chat_page.dart';
import '../widgets/firestore_page.dart';
import '../widgets/visualizar_widget.dart';
import '../widgets/crear_widget.dart';

// Widget para el manejo principal si tengo sesion o debo iniciar sesion
class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  ThemeController get controller => Get.find();
  // Atributo
  int _selectIndex = 0;
  // Controlador de autenticacion
  AuthenticationController authenticationController = Get.find();
  // Listado de Widgets a mostrar
  static final List<Widget> _widgets = <Widget>[
    const FireStorePage(),
    const ChatPage(),
    GpsPage(),
    const VisualizarWidget(),
    const CrearWidget(),
  ];

  // Metodo para realizar cambio de Widget
  _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        controller: controller,
        tile: Text('Red Max Animes\n' + authenticationController.userEmail(),
            style: const TextStyle(fontSize: 16.0)),
        context: context,
      ),
      body: _widgets.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.gps_fixed), label: "Ubicacion"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_outlined), label: "Posts"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "New Posts"),
        ],
        currentIndex: _selectIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
