import 'package:flutter/material.dart';
import 'package:sos_ambiente/screens/add_report_screen.dart';
import 'package:sos_ambiente/screens/report_list_screen.dart';
import 'package:sos_ambiente/screens/report_map_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pageController = PageController(initialPage: 2, keepPage: true);

  final pageModels = [
    PageModel(title: 'Mapa de Alertas'),
    PageModel(title: 'Reportar'),
    PageModel(title: 'Lista de Alertas'),
  ];

  int _currentIndex = 2;

  bool searchMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: searchMode
            ? TextFormField(
                decoration: InputDecoration(
                  hintText: 'Procurar...',
                  // contentPadding: const EdgeInsets.all(8.0),
                  isDense: true,
                ),
                expands: false,
                maxLines: 1,
              )
            : Text(
                pageModels[_currentIndex].title,
              ),
        actions: <Widget>[
          if (_currentIndex != 1)
            IconButton(
              icon: Icon(searchMode ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  searchMode = !searchMode;
                });
              },
            )
        ],
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ReportMapScreen(),
          AddReportScreen(
            onReportCompleted: () {
              setState(() {
                _currentIndex = 2;
                pageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
              });
            },
          ),
          ReportListScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
          );
          searchMode = false;
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        elevation: 6.0,
        showUnselectedLabels: false,
        unselectedItemColor: Theme.of(context).disabledColor,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text(pageModels[0].title),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            title: Text(pageModels[1].title),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text(pageModels[2].title),
          ),
        ],
      ),
    );
  }
}

class PageModel {
  final String title;

  PageModel({@required this.title});
}
