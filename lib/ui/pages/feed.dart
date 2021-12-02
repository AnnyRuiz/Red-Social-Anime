import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widges/post_list.dart';

class Feed extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: PostList('feed'),
    );
  }

}