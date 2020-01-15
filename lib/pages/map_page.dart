import 'dart:async';

import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/product_listing_bloc.dart';
import 'package:catmanager/events/custom_dish_listing_event.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/events/product_listing_event.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  MapPage({
    Key key
  }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Position _position;
  StreamSubscription<Position> _positionStream;

  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  @override
  void initState() {
    super.initState();
    StreamSubscription<Position> _positionStream = geolocator.getPositionStream(locationOptions).listen(
        (Position position) {
          setState(() {
            _position = position;
          });
          print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Map'),
      ),
      body: Container(
        child: Builder(
          builder: (BuildContext context) {

            return new FlutterMap(
              options: new MapOptions(
//                center: new LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tiles.mapbox.com/v4/"
                      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
                    'id': 'mapbox.streets',
                  },
                ),
//                new MarkerLayerOptions(
//                  markers: [
//                    new Marker(
//                      width: 80.0,
//                      height: 80.0,
//                      point: new LatLng(51.5, -0.09),
//                      builder: (ctx) =>
//                      new Container(
//                        child: new FlutterLogo(),
//                      ),
//                    ),
//                  ],
//                ),
              ],
            );

            if (_position == null) {
              return Center(child: Text('Position...'));
            }

            return Center(child: Text('Position: ${_position.latitude.toString()}; ${_position.longitude.toString()}'));
          }
        ),
      ),
    );
  }
}