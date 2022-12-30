import 'package:geolocator/geolocator.dart';
import 'dart:async';

typedef PositionCallback = Function(Position position);

class GPS {
  late StreamSubscription<Position> _positionStream;

  bool isAccessGranted(LocationPermission permission) {
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (isAccessGranted(permission)) {
      return true;
    }
    permission = await Geolocator.requestPermission();
    return isAccessGranted(permission);
  }

  Future<void> startPositionStream(PositionCallback callback) async {
    bool permisstionGranted = await requestPermission();
    if (!permisstionGranted) {
      throw Exception("User did not granted gps permission.");
    }
    _positionStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
    )).listen(callback);
  }

  Future<void> stopPositionStream() async {
    await _positionStream.cancel();
  }
}
