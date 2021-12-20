import 'dart:async';

import 'package:flutter/material.dart';
import 'package:red_max_anime/domain/use_case/controllers/location.dart';
import 'package:red_max_anime/domain/use_case/controllers/permissions.dart';
import 'package:red_max_anime/domain/use_case/controllers/theme_controller.dart';
import 'package:red_max_anime/domain/use_case/location_management.dart';
import 'package:red_max_anime/domain/use_case/permission_management.dart';
import 'package:red_max_anime/domain/use_case/theme_management.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class GpsPage extends StatefulWidget {
  const GpsPage({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<GpsPage> {
  // Dependency injection: setting up state management
  late final ThemeController controller = Get.put(ThemeController());
  // Theme management
  late final ThemeManager controller2 = ThemeManager();
  bool isLoaded = false;

  late PermissionsController permissionsController;
  late LocationController locationController;
  late LocationManager manager;

  Future<void> initializeTheme() async {
    controller.darkMode = await controller2.storedTheme;
    setState(() => isLoaded = true);
  }

  @override
  void initState() {
    ever(controller.reactiveDarkMode, (bool isDarkMode) {
      controller2.changeTheme(isDarkMode: isDarkMode);
    });
    PermissionsController permissionsController =
        Get.put(PermissionsController());
    permissionsController.permissionManager = PermissionManager();
    Get.lazyPut(() => LocationController());
    initializeTheme();
    super.initState();
    permissionsController = Get.find();
    locationController = Get.find();
    manager = LocationManager();
    // Sera el encargado de refrescar la ubicacion cada 30 segundos
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      // Verifica que tienes los permisos y luego obten la ubicacion
      // Almacenala y tambien muestra un snackbar con los datos
      locationController.location.value = null;
      if (permissionsController.locationGranted) {
        final position = await manager.getCurrentLocation();
        locationController.location.value = position;
        Get.snackbar('Tu ubicación',
            'Latitud ${position.latitude}\nLongitud: ${position.longitude}\nAltitud: ${position.altitude}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: gpsScreen(),
        ),
      ),
    );
  }

  Widget gpsScreen() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Verifica que tienes los permisos y luego obten la ubicacion
                  // Almacenala y tambien muestra un snackbar con los datos
                  locationController.location.value = null;
                  if (permissionsController.locationGranted) {
                    final position = await manager.getCurrentLocation();
                    locationController.location.value = position;
                    Get.snackbar('Tu ubicación',
                        'Latitud ${position.latitude}\nLongitud: ${position.longitude}\nAltitud: ${position.altitude}');
                  }
                },
                child: const Text('Obtener Ubicacion'),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Obx(
                () => ElevatedButton(
                  onPressed: locationController.location.value != null
                      ? () async {
                          // Con los datos de ubicacion almacenados construye un enlace a Google Maps
                          // y lanzalo
                          final location = locationController.location.value;
                          final url =
                              "https://www.google.com/maps?q=${location?.latitude},${location?.longitude}";
                          await launch(url);
                        }
                      : null,
                  child: const Text('Abrir Maps'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
