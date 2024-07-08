import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hotel1/api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter/services.dart';


class LocationPage extends StatefulWidget {

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Future getLocation(String address)async{
     List<Location> locations = await locationFromAddress(address);
     setState(() {
       lng = locations[0].longitude;
       lat = locations[0].latitude;
       LatLng latLng = LatLng(locations[0].latitude,locations[0].longitude);
       location = latLng;
       _mapController.move(LatLng(locations[0].latitude, locations[0].longitude), 5.0);
     });
  }
  MapController _mapController = MapController();
  double _zoomLevel = 5.0;
  LatLng location  = LatLng(0, 0);
  TextEditingController area = TextEditingController();
  double lng = -122.4194,lat = 37.7749;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: InkWell(
              child: const Text(
                "submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: (){
                LocationMap['lng'] = location.longitude;
                LocationMap['lat'] = location.latitude;
                SuccessAlertBox(
                  context: context,
                  title: "Success",
                  messageText: "store location is complete"
                );
              },
            ),
          ),
          Container(
            width: 200,
            padding: const EdgeInsets.only(left: 20,bottom: 10,right: 10),
            child: TextFormField(
              controller: area,
              decoration: const InputDecoration(
                label: Text("search"),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),

              ),
              style: const TextStyle(
                  color: Colors.white
              ),
            ),
          ),
          IconButton(onPressed: () async{
             if(area.text.isEmpty){
               DangerAlertBox(
                 context: context,
                 title: "Wrong",
                 messageText: "there is nowhere to lock for it"
               );
             }
             else{
              await getLocation(area.text);
               print(location);
             }
          },
              icon: const Icon(Icons.search,size: 30,color: Colors.white,)
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
            center: LatLng(lat, lng), // Set your desired initial position
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
