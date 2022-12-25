import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/widgets/gps.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GPS _gps = GPS();
  Position? _userPosition;
  Exception? _exception;

  void _handlePositionStream(Position position) {
    setState(() {
      _userPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(_userPosition.toString())),
    );
  }

  @override
  void initState() {
    super.initState();
    _gps.startPositionStream(_handlePositionStream);
  }

  @override
  void dispose() {
    super.dispose();
    _gps.stopPositionStream();
  }
}
