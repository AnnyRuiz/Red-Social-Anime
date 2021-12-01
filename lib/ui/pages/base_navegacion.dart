import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'principal.dart';

class BaseNavegacion extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GetMaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: Principal()
    );
  }

}