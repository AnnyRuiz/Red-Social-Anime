import 'package:red_max_anime/domain/services/location.dart';
import 'package:geolocator/geolocator.dart';

class GpsService implements LocationInterface {
  @override
  Future<Position> getCurrentLocation() async {
    // Usando el paquete Geolocator obtenga la posicion actual
    return await Geolocator.getCurrentPosition();
  }
}
