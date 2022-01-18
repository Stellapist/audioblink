import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sf',
        colorScheme: myScheme,
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget{
  const MyStatefulWidget({Key? key}): super(key: key);

  @override
  State<MyStatefulWidget> createState() =>_MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Tabs.searchTab(),
    Tabs.listeningTab(),
    Tabs.libraryTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Αναζήτηση',
              icon: Icon(Icons.travel_explore_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Ακούω Τώρα',
              icon: Icon(Icons.headphones_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Βιβλιοθήκη',
              icon: Icon(Icons.library_books_rounded),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: myScheme.secondary,
          unselectedItemColor: myScheme.primary,
          onTap: _onItemTapped,
        ),
    );
  }
}

const ColorScheme myScheme = ColorScheme(
    primary: Color.fromRGBO(49, 32, 73, 1.0),
    primaryVariant: Color.fromRGBO(49, 32, 73, 0.7),
    secondary: Color.fromRGBO(255, 137, 0, 1.0),
    secondaryVariant: Color.fromRGBO(255, 137, 0, 0.7),
    surface: Color.fromRGBO(49, 32, 73, 1.0),
    background: Colors.white,
    error: Colors.redAccent,
    onPrimary: Colors.white,
    onSecondary:  Color.fromRGBO(49, 32, 73, 1.0),
    onSurface: Colors.white,
    onBackground: Color.fromRGBO(49, 32, 73, 0.8),
    onError: Colors.white,
    brightness: Brightness.light,
);

