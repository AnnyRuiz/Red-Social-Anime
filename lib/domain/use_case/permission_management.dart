import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<bool> gpsPermission() async {
    // Retorna el estado del permiso de ubicacion
    var status = await Permission.location.status;
    return status.isGranted;
  }

  Future<bool> requestGpsPermission() async {
    // Solicita los permisos necesarios
    var status = await Permission.location.request();
    return status.isGranted;
  }
}
