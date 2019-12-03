import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportMapScreen extends StatefulWidget {
  ReportMapScreen({Key key}) : super(key: key);

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  _ReportMapScreenState createState() => _ReportMapScreenState();
}

class _ReportMapScreenState extends State<ReportMapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: ReportMapScreen._center,
        zoom: 11.0,
      ),
      markers: _markers,
      trafficEnabled: false,
      onLongPress: (latLong) {
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId(
                latLong.toString(),
              ),
              draggable: false,
              position: latLong,
              visible: true,
            ),
          );
        });
      },
    );
  }
}
