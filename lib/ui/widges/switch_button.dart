import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget{

  bool switchValue = false;

  SwitchButton(this.switchValue);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SwitchButton(switchValue);
  }

}

class _SwitchButton extends State<SwitchButton>{

  bool _switchValue = false;

  _SwitchButton(this._switchValue);

  void cambiarSwitch(value){
    setState(() {
      _switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoSwitch(
        value: _switchValue,
        onChanged: cambiarSwitch
    );
  }

}