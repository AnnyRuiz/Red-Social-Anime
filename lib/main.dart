import 'package:flutter/material.dart';
import 'package:max_anime/ui/app.dart';
import 'package:get/get.dart';
import 'package:max_anime/domain/use_cases/controllers/authentication_controller.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const App());
}
