import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LocationUpdate extends StatefulWidget {
  final double lat, lng;
  final bool request;
  final String text;

  LocationUpdate(
      {this.text = "",
      this.lat = 40.730610,
      this.lng = -73.935242,
      this.request = false});

  @override
  State<StatefulWidget> createState() {
    return LocationUpdateState();
  }
}

class LocationUpdateState extends State<LocationUpdate> {
  Marker markers;

  newMap() {
    setState(() {
      markers = Marker(
        width: 45.0,
        height: 45.0,
        point: LatLng(widget.lat, widget.lng),
        builder: (context) => Container(
          child: IconButton(
              icon: Icon(Icons.location_on),
              color: Colors.red,
              iconSize: 45.0,
              onPressed: () => Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(widget.text)))),
        ),
      );
    });
    return FlutterMap(
      options: MapOptions(
          interactive: true,
         // center: LatLng(widget.lat, widget.lng),
          maxZoom: 20.0),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(markers: [
          setMarkers()
        ]),
      ],
    );
  }

  defaultMap() {
    return FlutterMap(
      options: MapOptions(
          interactive: true,
           center: LatLng(widget.lat, widget.lng),
          maxZoom: 20.0),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
//        MarkerLayerOptions(markers: [
//          Marker(point: LatLng(widget.lat, widget.lng))
//        ]),
      ],
    );
  }

//
  setMarkers() {
    return markers;
  }
  @override
  Widget build(BuildContext context) {
    if(widget.request==false){
      return defaultMap();
    }
    else {
      return newMap();
    }
  }
}
