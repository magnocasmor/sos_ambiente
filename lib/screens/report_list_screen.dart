import 'package:flutter/material.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            ReportCard(
              imageUrl:
                  'https://s3.amazonaws.com/ionic-io-static/km2d1KITDiKPpfTN8M3l_50-750-waterpol-750.jpg',
              title: 'Poluição no rio x',
              subtitle: 'Cano quebrado faz esgoto vazar dentro de rio.',
            ),
            ReportCard(
              imageUrl:
                  'https://s3.amazonaws.com/ionic-io-static/PFXfTVUFROSueigIrHMF_DESMATAMENTO3.JPG',
              title: 'Desmatamento criminoso',
              subtitle: 'Várias árvores sendo retiradas.',
            ),
            ReportCard(
              imageUrl:
                  'https://s3.amazonaws.com/ionic-io-static/URGYQ5KT3i0vGJmgwbDA_a-poluicao-traz-consequencias-graves-todos-os-seres-vivos-um-ecossistema-58c19dab654d0.jpg',
              title: 'Lixo na praia X',
              subtitle: 'Bastante lixo jogado por visitantes.',
            ),
            ReportCard(
              imageUrl:
                  'https://s3.amazonaws.com/ionic-io-static/PG5vZeSTZOgzVJu8Zes0_tn_59afea1899_queimadas.jpg',
              title: 'Área florestal sendo queimada',
              subtitle: 'Queimada no rua Y.',
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const ReportCard({
    Key key,
    this.imageUrl,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              image: DecorationImage(
                  image: NetworkImage(
                    imageUrl,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: StatefulBuilder(
              builder: (context, setState) {
                return IconButton(
                  icon:
                      Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  color: isFavorite ? Colors.red : null,
                  onPressed: () {
                    setState(
                      () {
                        isFavorite = !isFavorite;
                      },
                    );
                  },
                );
              },
            ),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
