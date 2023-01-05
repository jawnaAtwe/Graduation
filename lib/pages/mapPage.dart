import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/pages/fetchdata.dart';
import 'package:untitled/models/GetLocation.dart';
import 'dart:math' show cos, sqrt, asin;

   double XX=32.18333;
   double YY=35.149900;
 late  List<GetLocation> myListget=[];
class MapPage extends StatefulWidget {
   
  double currentLat, currentLng;
  MapPage({required this.currentLat, required this.currentLng});
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var myMarkers = HashSet<Marker>(); //collection
  late BitmapDescriptor marketMarker; //attribute
  late BitmapDescriptor currentMarker; //attribute

  List<Polyline> myPolyline = [];

  getCustomMarker() async {
    marketMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/source_pin_android.png");
    currentMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/images/destination_pin_cat5_android.png");
  }
  getlocation(double currentLat,double currentLng)async{
    print('ko');
// final prefs = await SharedPreferences.getlocation();
myListget=await fetch.getlocation();

double min=100000.11;
double x=0.0;
double y=0.0;

myListget.forEach((post) { 
// if(post.latitude-currentLat>0.0)
// {
// if(post.latitude-currentLat<min)
// min=post.latitude-currentLat;
// x=post.latitude;

// }else{
//   if(currentLat-post.latitude<min)
// min=currentLat-post.latitude;
// x=post.latitude;
// }
var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((post.latitude - currentLat) * p)/2 + 
          c(currentLat * p) * c(post.latitude * p) * 
          (1 - c((post.longitude - currentLng) * p))/2;
    if( 12742 * asin(sqrt(a))<min){
    min=12742 * asin(sqrt(a));
x=post.latitude;
y=post.longitude;
    }

});
XX=x;
YY=y;
print(x);
print(" ===");
print(y);
  }
  @override
  fetchdata fetch=new fetchdata();
  void initState() {
    super.initState();
    getlocation(widget.currentLat,widget.currentLng);
    getCustomMarker();
    createPloyLine();
  }

  createPloyLine() {
    getlocation(widget.currentLat,widget.currentLng);
    myPolyline.add(
      Polyline(
          polylineId: PolylineId('1'),
          color: Color.fromARGB(255, 41, 161, 63),
          width: 3,
          points: [
            LatLng(widget.currentLat, widget.currentLng),


            ////////
            LatLng(XX, YY),
          ]),
    );
  }

  // Set<Polygon> myPolygon() {
  //   var polygonCoords = <LatLng>[];
  //   polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));
  //   polygonCoords.add(LatLng(37.43006265331129, -122.08832357078792));
  //   polygonCoords.add(LatLng(37.43006265331129, -122.08332357078792));
  //   polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));

  //   var polygonSet = Set<Polygon>();
  //   polygonSet.add(
  //     Polygon(
  //       polygonId: PolygonId('1'),
  //       points: polygonCoords,
  //       strokeWidth: 1,
  //       strokeColor: Colors.red,
  //     ),
  //   );

  //   return polygonSet;
  // }

  Set<Circle> myCircles = Set.from([
    Circle(
      circleId: CircleId('1'),
      ////////
      center: LatLng(XX, YY),
      radius: 250,
      strokeWidth: 3,
      strokeColor: Color.fromARGB(255, 41, 161, 63),
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google Map'),
          backgroundColor: Color.fromARGB(255, 172, 190, 90),
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.currentLat, widget.currentLng),
                  zoom: 14),
              onMapCreated: (GoogleMapController googleMapController) {
                setState(() {
                  myMarkers.add(
                    Marker(
                      markerId: MarkerId('1'),
                      ///////
                      position: LatLng(XX, YY),
                      infoWindow: InfoWindow(
                          title: 'Market',
                          snippet:
                              'this is the closest market to your current location'),
                      onTap: () {
                        print('Marker tabed');
                      },
                      icon: marketMarker,
                    ),
                  );

                  myMarkers.add(
                    Marker(
                      markerId: MarkerId('2'),
                      position: LatLng(widget.currentLat, widget.currentLng),
                      infoWindow: InfoWindow(
                          title: 'Your current location', snippet: ''),
                      onTap: () {
                        print(widget.currentLat);
                        print(widget.currentLng);
                      },
                      icon: currentMarker,
                    ),
                  );
                });
              },
              markers: myMarkers,
              // polygons: myPolygon(),
              circles: myCircles,
              polylines: myPolyline.toSet(),
            )
          ],
        ));
  }
}
