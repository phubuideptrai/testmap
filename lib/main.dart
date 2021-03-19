import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:random_color/random_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GoogleMapController _controller;

  final CameraPosition _initialPosition = CameraPosition(target: LatLng(10.869981610276652, 106.80372226645736), zoom: 12.0);
 int markerID = 1;
  final List<Marker> markers = [];
  Set<Polyline> lines = {};
  Point _point;
  @override
  void initState() {
    super.initState();
    markers.add(Marker(position: LatLng(10.869981610276652, 106.80372226645736), markerId: MarkerId("0")));
  }

  addMarker(cordinate){
    markerID++;
    RandomColor _randomColor = RandomColor();
    Color _color = _randomColor.randomColor();
    setState(() {

      markers.add(Marker(position: cordinate, markerId: MarkerId(markerID.toString())));
      lines.add( Polyline(
        points: [LatLng(cordinate.latitude,cordinate.longitude),markers[markerID-2].position],
        color: _color,
        polylineId: PolylineId(markerID.toString()),
        )
        );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (controller){
          setState(() {
            _controller = controller;
          });
        },
        markers: markers.toSet(),
        polylines: lines,
        onTap: (cordinate){
          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
          addMarker(cordinate);
        },
      ),
    );
  }
}






