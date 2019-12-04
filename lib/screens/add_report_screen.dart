import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class AddReportScreen extends StatefulWidget {
  final VoidCallback onReportCompleted;

  AddReportScreen({
    Key key,
    @required this.onReportCompleted,
  }) : super(key: key);

  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final _userlocation = Location();

  final listKey = GlobalKey<AnimatedListState>();

  final types = [
    'Queimada',
    'Desmatamento',
    'Poluição',
    'Outros',
  ];

  final photos = [];

  GoogleMapController _controller;

  Marker _marker;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    String selectedType = types.first;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Selecione no mapa o local do incidente',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              height: 300.0,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FutureBuilder<LocationData>(
                future: _userlocation.getLocation(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  final locationData = snapshot.data;

                  return GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target:
                          LatLng(locationData.latitude, locationData.longitude),
                      zoom: 18.0,
                    ),
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer()))
                      ..add(Factory<ScaleGestureRecognizer>(
                          () => ScaleGestureRecognizer()))
                      ..add(Factory<TapGestureRecognizer>(
                          () => TapGestureRecognizer()))
                      ..add(Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())),
                    markers: _marker is Marker ? Set.from([_marker]) : null,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    trafficEnabled: false,
                    onTap: (latLong) {
                      setState(
                        () {
                          _marker = Marker(
                            markerId: MarkerId(
                              latLong.toString(),
                            ),
                            draggable: false,
                            position: latLong,
                            visible: true,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título do incidente',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descrição',
                  hintText: 'Ex: Cano quebrado causou o vazamento no rio...',
                ),
                maxLines: 3,
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tipo do incidente',
                    ),
                    items: types
                        .map(
                          (type) => DropdownMenuItem<String>(
                            child: Text(type),
                            value: type,
                          ),
                        )
                        .toList(),
                    onChanged: (type) => setState(() => selectedType = type),
                    onSaved: (type) => setState(() => selectedType = type),
                  ),
                );
              },
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  children: <Widget>[
                    Flexible(
                      child: SizedBox(
                        height: 76.0,
                        child: AnimatedList(
                          key: listKey,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          initialItemCount: photos.length,
                          itemBuilder: (context, index, animation) {
                            return ScaleTransition(
                              scale: animation.drive(
                                CurveTween(curve: Curves.elasticOut),
                              ),
                              child: Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 76.0,
                                    margin: const EdgeInsets.only(right: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Theme.of(context).primaryColor,
                                      image: DecorationImage(
                                        image: FileImage(photos[index]),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -4.0,
                                    right: 4.0,
                                    width: 20.0,
                                    height: 20.0,
                                    child: FlatButton(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 12.0,
                                      ),
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          width: .5,
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: Colors.black,
                                      onPressed: () {
                                        listKey.currentState.removeItem(
                                          index,
                                          (context, animation) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: ScaleTransition(
                                                scale: animation.drive(
                                                  CurveTween(
                                                    curve: Curves.elasticOut,
                                                  ),
                                                )..addStatusListener((status) {
                                                    photos.removeAt(index);
                                                    setState(() {});
                                                  }),
                                                child: Container(
                                                  width: 76.0,
                                                  margin: const EdgeInsets.only(
                                                      right: 8.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          photos[index]),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 76.0,
                      height: 76.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(0.0),
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: photos.length >= 3
                            ? null
                            : () async {
                                final newPhoto = await ImagePicker.pickImage(
                                  source: ImageSource.camera,
                                );
                                if (newPhoto is File)
                                  setState(() {
                                    photos.add(newPhoto);
                                    listKey.currentState
                                        .insertItem(photos.indexOf(newPhoto));
                                  });
                              },
                      ),
                    )
                  ],
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: RaisedButton(
                child: Text('Reportar'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Obrigado por sua ajuda!'),
                        content: Text(
                            'O incidente foi reportado com sucesso. Aguardemos para que as devidas medidas sejam tomadas.'),
                        shape: RoundedRectangleBorder(),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.onReportCompleted?.call();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
