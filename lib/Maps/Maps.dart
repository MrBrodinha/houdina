import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:houdina/Maps/location_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

String google_api_key = "AIzaSyCTmJLBFlHfmGCCUMMjoqXKO8n5NNCv_wY";

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => MapsState();
}

class MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  var sourcelat = 40.1668615;
  var sourcelng = -7.7876066;

  String? _currentAddress;
  Position? _currentPosition;

  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();

  int _polylineIdCounter = 1;

  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();

    final perms = _handleLocationPermission();

    _initialCameraPosition = CameraPosition(
      target: LatLng(sourcelat, sourcelng),
      zoom: 20,
    );

    _getCurrentPosition();
    _setMarkers(LatLng(sourcelat, sourcelng));
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      print(position);
    }).catchError((e) {
      debugPrint(e);
    });

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        sourcelat = _currentPosition?.latitude ?? sourcelat;
        sourcelng = _currentPosition?.longitude ?? sourcelng;
        _initialCameraPosition = CameraPosition(
          target: LatLng(sourcelat, sourcelng),
          zoom: 20,
        );

        _setMarkers(LatLng(sourcelat, sourcelng));
      });
      _getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(sourcelat, sourcelng)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _originController.text =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
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
                  ),
                  TextFormField(
                    controller: _destinationController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'Destination'),
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
                  icon: Icon(Icons.search))
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polylines: _polylines,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }
}
