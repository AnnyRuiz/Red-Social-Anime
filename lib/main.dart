import 'package:flutter/material.dart';
import 'package:max_anime/domain/use_cases/controllers/main_feed_controller.dart';
import 'package:max_anime/ui/app.dart';
import 'package:get/get.dart';
import 'package:max_anime/domain/use_cases/controllers/authentication_controller.dart';
import 'package:max_anime/domain/use_cases/controllers/profile_controller.dart';
import 'package:max_anime/domain/use_cases/controllers/chats_controller.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(MainFeedController());
  Get.put(ProfileController());
  Get.put(AuthController());
  Get.put(ChatsController());

  runApp(const App());
}
