import 'dart:ffi';

import 'package:flutter/material.dart';
import '../pages/feed.dart';
import '../pages/notifications.dart';
import '../pages/profile.dart';

class BottomBar{

  List<BottomNavigationBarItem> bottom_items() {
    // TODO: implement build
    return [
        BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: ""
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: ""
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ""
        ),
      ];
  }

}