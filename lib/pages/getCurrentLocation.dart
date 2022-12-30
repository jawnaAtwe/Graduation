import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/pages/mapPage.dart';
import 'package:untitled/widgets/gps.dart';

import '../widgets/themebutton.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GPS _gps = GPS();
  Position? _userPosition;
  Exception? _exception;
  double? currentLat;
  double? currentLng;

  void _handlePositionStream(Position position) {
    setState(() {
      _userPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromARGB(255, 53, 78, 67),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 1.0,
                    child: Image.asset('assets/images/maap.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Map',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 172, 190, 90),
                              fontSize: 40,
                              fontWeight: FontWeight.w300)),
                      Text('_____________',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 172, 190, 90),
                              fontSize: 25,
                              fontWeight: FontWeight.w200)),
                      SizedBox(height: 30),
                      Text(
                          'This map help you to find the closest Market to your\n current Location.\nThe Markets that have an account in Appetizing',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 113, 126, 54),
                              fontSize: 14)),
                      SizedBox(height: 35),
                      ThemeButton(
                        label: 'Get Your Current Location',
                        highlight: Colors.green[900],
                        color: Color.fromARGB(255, 172, 190, 90),
                        onClick: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MapPage(
                                currentLat: _userPosition!.latitude,
                                currentLng: _userPosition!.longitude);
                          }));
                        },
                      ),
                    ],
                  ),
                )

                // Center(
                //   child: ThemeButton(
                //     label: 'GetYour Current Location',
                //     highlight: Colors.green[900],
                //     color: Color.fromARGB(255, 172, 190, 90),
                //     onClick: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (context) {
                //         return MapPage(
                //             currentLat: _userPosition!.latitude,
                //             currentLng: _userPosition!.longitude);
                //       }));
                //     },
                //   ),
                // )
              ],
            )));
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
