import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget{

  bool switchValue = false;
  final VoidCallback funcion;

  SwitchButton({Key? key, required this.switchValue, required this.funcion});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SwitchButton();
  }

}

class _SwitchButton extends State<SwitchButton>{

  void cambiarSwitch(value){
    setState(() {
      widget.switchValue = value;
    });
    widget.funcion;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoSwitch(
        value: widget.switchValue,
        onChanged: cambiarSwitch
    );
  }

}