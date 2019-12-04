import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ReportMapScreen extends StatefulWidget {
  ReportMapScreen({Key key}) : super(key: key);

  @override
  _ReportMapScreenState createState() => _ReportMapScreenState();
}

class _ReportMapScreenState extends State<ReportMapScreen> {
  static const String POLLUTION_ICON = 'assets/markers/pollution.png';
  static const String DEFORESTATION_ICON = 'assets/markers/deforestation.png';
  static const String FIRE_ICON = 'assets/markers/fire.png';
  static const String OTHERS_ICON = 'assets/markers/other.png';

  final _userlocation = Location();
  final _userTarget = Map<String, double>();

  final Set<Marker> _markers = Set<Marker>();

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<LocationData> _process() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, OTHERS_ICON);

    _markers.addAll(
      [
        Marker(
          markerId: MarkerId('1'),
          position: LatLng(-2.532145, -44.273008),
          draggable: false,
          icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(POLLUTION_ICON, 100),
          ),
          infoWindow: InfoWindow(
            title: 'Poluição do rio x',
            snippet: 'Cano quebrado faz esgoto vazar dentro de rio',
          ),
        ),
        Marker(
          markerId: MarkerId('2'),
          position: LatLng(-2.531112, -44.276134),
          draggable: false,
          icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(DEFORESTATION_ICON, 100),
          ),
          infoWindow: InfoWindow(
            title: 'Desmatamento criminoso',
            snippet: 'Várias árvores sendo retiradas',
          ),
        ),
        Marker(
          markerId: MarkerId('3'),
          position: LatLng(-2.487479, -44.285690),
          draggable: false,
          icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(POLLUTION_ICON, 100),
          ),
          infoWindow: InfoWindow(
            title: 'Lixo na praia X',
            snippet: 'Bastante lixo jogado por visitantes',
          ),
        ),
        Marker(
          markerId: MarkerId('4'),
          position: LatLng(-2.534977, -44.280098),
          draggable: false,
          icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(FIRE_ICON, 100),
          ),
          infoWindow: InfoWindow(
            title: 'Área florestal sendo queimada',
            snippet: 'Queimada na rua Y',
          ),
        ),
      ],
    );
    return await _userlocation.getLocation();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FutureBuilder<LocationData>(
            future: _process(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              final locationData = snapshot.data;

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(locationData.latitude, locationData.longitude),
                  zoom: 15.0,
                ),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: _markers,
                trafficEnabled: false,
                // onLongPress: (latLong) {
                //   setState(
                //     () {
                //       _markers.add(
                //         Marker(
                //           markerId: MarkerId(
                //             latLong.toString(),
                //           ),

                //           draggable: false,
                //           position: latLong,
                //           visible: true,
                //         ),
                //       );
                //     },
                //   );
                // },
              );
            },
          ),
        ),
        SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(POLLUTION_ICON),
                  )),
                  Text('Poluição'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(DEFORESTATION_ICON),
                  )),
                  Text('Desmatamento'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(FIRE_ICON),
                  )),
                  Text('Queimadas'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(OTHERS_ICON),
                  )),
                  Text('Outros'),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
