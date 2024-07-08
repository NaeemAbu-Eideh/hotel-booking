import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hotel1/api.dart';
import 'package:latlong2/latlong.dart';

import '../notification/notification_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int i = 0;
  MapController _mapController = MapController();
  double _zoomLevel = 10.0;
  LatLng location  = LatLng(0, 0);
  double lng = -122.4194,lat = 37.7749;
  LatLng hotalLocation = LatLng(0.0,0.0);
  Timer? timer;
  Future startTimer()async{}

  @override
  void initState() {
    setState(() {
      lat = double.parse(LocationMap['lat']);
      lng = double.parse(LocationMap['lon']);
      location = LatLng(lng,lat);
      hotalLocation = LatLng(lng,lat);
    });
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            i = index;
            if(i == 0){
              Navigator.of(context).pushReplacementNamed("informationOfHotel");
            }
            else if(i == 1){
              int index = 0;
              for(int i=0;i<Hotels.length;i++){
                if(Hotels[i]['name'] == info['hotel']){index = i;}
              }
              LocationMap['lng'] = Hotels[index]['lon'];
              LocationMap['lat'] = Hotels[index]['lat'];
              Navigator.of(context).pushReplacementNamed("map");
            }
          });
        },
        currentIndex: i,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.perm_device_information),label: "information"),
          BottomNavigationBarItem(icon: Icon(Icons.map),label: "map"),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Map", style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),),),
      body: FlutterMap(
        options: MapOptions(
            center: LatLng(lng, lat), // Set your desired initial position
            zoom: _zoomLevel,
            onTap: (point){
              setState(() {
                location = point;
                print(location);
              });
            }
        ),
        mapController: _mapController,
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: location,
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                  ),
                ),
              ),
              Marker(
                width: 100.0,
                height: 100.0,
                point: hotalLocation,
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.blue,
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoomOut',
            onPressed: () {
              setState(() {
                _zoomLevel -= 1;
                _mapController.move(_mapController.center, _zoomLevel);
              });
            },
            child: Icon(Icons.zoom_out),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'zoomIn',
            onPressed: () {
              setState(() {
                _zoomLevel += 1;
                _mapController.move(_mapController.center, _zoomLevel);
              });
            },
            child: Icon(Icons.zoom_in),
          ),
        ],
      ),
    );
  }
}
