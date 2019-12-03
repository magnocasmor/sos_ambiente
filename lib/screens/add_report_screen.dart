import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddReportScreen extends StatelessWidget {
  final VoidCallback onReportCompleted;
  AddReportScreen({
    Key key,
    @required this.onReportCompleted,
  }) : super(key: key);

  final listKey = GlobalKey<AnimatedListState>();

  final types = [
    'Queimada',
    'Desmatamento',
    'Poluição',
    'Outros',
  ];

  final photos = [];

  @override
  Widget build(BuildContext context) {
    String selectedType = types.first;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Selecione no mapa o local do incidente'),
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
                        content: Text('O incidente foi reportado com sucesso. Aguardemos para que as devidas medidas sejam tomadas.'),
                        shape: RoundedRectangleBorder(),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.of(context).pop();
                              onReportCompleted?.call();
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
