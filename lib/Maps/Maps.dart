// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:houdina/maps/location_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

String googleApiKey = "AIzaSyCTmJLBFlHfmGCCUMMjoqXKO8n5NNCv_wY";

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => MapsState();
}

class MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  var sourcelat = 40.1668615;
  var sourcelng = -7.7876066;

  final Set<Marker> _markers = <Marker>{};
  final Set<Polyline> _polylines = <Polyline>{};

  int _polylineIdCounter = 1;

  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(40.1668615, -7.7876066),
    zoom: 20,
  );

  String _mapStyle = '';

  @override
  void initState() {
    super.initState();
    _loadMapStyleFromFirebase().then((style) {
      setState(() {
        _mapStyle = style;
      });
    });
    _handleLocationPermission();
    _setMarkers(LatLng(sourcelat, sourcelng));
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

  Future<String> _loadMapStyleFromFirebase() async {
    if (_mapStyle.isNotEmpty) {
      return _mapStyle; // Return existing style if already loaded
    }

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String downloadURL =
          await storage.ref('aplicacao/maps.json').getDownloadURL();
      final response = await http.get(Uri.parse(downloadURL));
      return response.body;
    } catch (e) {
      debugPrint('Error loading map style: $e');
      return '';
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
    controller.setMapStyle(_mapStyle);
  }

  Color customColor = const Color.fromRGBO(25, 95, 255, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height *
                  0.10, // Add the padding of the bar here
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.60,
              height: MediaQuery.of(context).size.height * 0.10,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Maps",
                    style: TextStyle(
                      color: Color.fromRGBO(25, 95, 255, 1.0),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0, // Top padding
                left: 8.0, // Left side padding
                right: 8.0, // Right side padding
                bottom: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: customColor,
                      width: 2), // Blue border around the map
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      12), // Clip the map to the rounded corners
                  child: FutureBuilder(
                    future: _loadMapStyleFromFirebase(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return GoogleMap(
                          mapType: MapType.normal,
                          markers: _markers,
                          polylines: _polylines,
                          initialCameraPosition: _initialCameraPosition,
                          onMapCreated: _onMapCreated,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0, // Add padding to the top of the first Row
                  left: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _originController,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(color: customColor), // Set text color
                        decoration: InputDecoration(
                          hintText: 'Origin',
                          hintStyle: TextStyle(
                              color: customColor
                                  .withOpacity(0.5)), // Set hint text color
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: customColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: customColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: customColor, width: 2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8), // Spacing between text fields
                    Expanded(
                      child: TextFormField(
                        controller: _destinationController,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(color: customColor), // Set text color
                        decoration: InputDecoration(
                          hintText: 'Destination',
                          hintStyle: TextStyle(
                              color: customColor
                                  .withOpacity(0.5)), // Set hint text color
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: customColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: customColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: customColor, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0, // Padding around the IconButton
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.search, color: customColor),
                    onPressed: () async {
                      // Check if either text field is empty
                      if (_originController.text.isEmpty ||
                          _destinationController.text.isEmpty) {
                        // Do nothing if any text field is empty
                        return;
                      }
                      var directions = await LocationService().getDirections(
                          _originController.text, _destinationController.text);
                      _showRoad(
                          directions['start_location']['lat'],
                          directions['start_location']['lng'],
                          directions['end_location']['lat'],
                          directions['end_location']['lng'],
                          directions['bounds_ne'],
                          directions['bounds_sw']);
                      _setPolyline(directions['polyline_decoded']);
                    },
                    color: customColor,
                    iconSize: 24,
                    splashRadius: 24,
                    splashColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _showRoad(double lat, double lng, double lat2, double lng2,
      Map<String, dynamic> boundsNE, Map<String, dynamic> boundsSW) async {
    _markers.clear();
    _polylines.clear();
    final LatLng newPlace = LatLng(lat, lng);
    final LatLng newPlace2 = LatLng(lat2, lng2);

    _initialCameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: _initialCameraPosition.zoom,
    );

    _setMarkers(newPlace);
    _setMarkers(newPlace2);
  }
}
