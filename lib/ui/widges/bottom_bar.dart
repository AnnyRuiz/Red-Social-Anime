import 'dart:ffi';

import 'package:flutter/material.dart';
import '../pages/feed.dart';
import '../pages/notifications.dart';
import '../pages/profile.dart';

class BottomBar{

  List<BottomNavigationBarItem> bottom_items() {
    return [
        BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: ""
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: ""
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ""
        ),
      ];
  }

}