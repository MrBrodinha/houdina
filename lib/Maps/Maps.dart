// ignore_for_file: use_build_context_synchronously

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

  final CameraPosition _initialCameraPosition = const CameraPosition(
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

  Future<void> _goToMyLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 20.0,
        ),
      ));

      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'My Location'),
          ),
        );
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
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

  Future<void> _showRoad(double lat, double lng, double lat2, double lng2,
      Map<String, dynamic> boundsNE, Map<String, dynamic> boundsSW) async {
    _markers.clear();
    final GoogleMapController controller = await _controller.future;
    final LatLng newPlace = LatLng(lat, lng);
    final LatLng newPlace2 = LatLng(lat2, lng2);

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
    _setMarkers(newPlace2);
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
    _controller.complete(controller);
    if (_mapStyle.isNotEmpty) {
      controller.setMapStyle(_mapStyle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _goToMyLocation,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(children: [
                  TextFormField(
                    controller: _originController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(hintText: 'Origin'),
                  ),
                  TextFormField(
                    controller: _destinationController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(hintText: 'Destination'),
                  )
                ]),
              ),
              IconButton(
                  onPressed: () async {
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
                  icon: const Icon(Icons.search))
            ],
          ),
          Expanded(
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
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
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
}
