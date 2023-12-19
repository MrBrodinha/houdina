import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:houdina/Aplicacao/location_services.dart';

String google_api_key = "AIzaSyCTmJLBFlHfmGCCUMMjoqXKO8n5NNCv_wY";

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  static const LatLng source = LatLng(40.1668615, -7.7876066);
  static const LatLng destination = LatLng(40.2807, -7.4999);

  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();

  int _polylineIdCounter = 1;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: source,
    zoom: 20,
  );

  @override
  void initState() {
    super.initState();

    _setMarkers(source);
  }

  void _setMarkers(LatLng point) {
    setState(() {
      final String markerIdVal = 'marker_${point.latitude}_${point.longitude}';
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(Polyline(
        polylineId: PolylineId(polylineIdVal),
        color: Colors.red,
        points: points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList(),
        width: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(children: [
                  TextFormField(
                    controller: _originController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'Origin'),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  TextFormField(
                    controller: _destinationController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'Destination'),
                    onChanged: (value) {
                      print(value);
                    },
                  )
                ]),
              ),
              IconButton(
                  onPressed: () async {
                    var directions = await LocationService().getDirections(
                        _originController.text, _destinationController.text);
                    _goToPlace(
                        directions['start_location']['lat'],
                        directions['start_location']['lng'],
                        directions['bounds_ne'],
                        directions['bounds_sw']);

                    _setPolyline(directions['polyline_decoded']);
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(double lat, double lng, Map<String, dynamic> boundsNE,
      Map<String, dynamic> boundsSW) async {
    final GoogleMapController controller = await _controller.future;
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];
    final LatLng newPlace = LatLng(lat, lng);

    print('Moving to $newPlace');

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: newPlace, zoom: 20),
    ));

    controller.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        northeast: LatLng(boundsNE['lat'], boundsNE['lng']),
        southwest: LatLng(boundsSW['lat'], boundsSW['lng']),
      ),
      50,
    ));
    _setMarkers(newPlace);
  }
}
