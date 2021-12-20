import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  // Observables
  final location = Rx<Position?>(null);
}
