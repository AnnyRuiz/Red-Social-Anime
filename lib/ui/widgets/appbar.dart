import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:red_max_anime/domain/controller/authentication_controller.dart';
import 'package:red_max_anime/domain/use_case/controllers/theme_controller.dart';

class CustomAppBar extends AppBar {
  final Widget tile;
  final BuildContext context;
  final ThemeController controller;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar({
    Key? key,
    required this.controller,
    required this.context,
    required this.tile,
  }) : super(
          key: key,
          centerTitle: true,
          title: tile,
          actions: [
            IconButton(
              icon: Obx(
                () => Icon(
                  controller.darkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
              ),
              onPressed: () => controller.darkMode = !controller.darkMode,
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                _logout();
              },
            ),
          ],
        );
}

_logout() async {
  AuthenticationController authenticationController = Get.find();
  try {
    await authenticationController.logOut();
  } catch (e) {
    logError(e.toString());
  }
}
