import 'dart:ui';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'misc.dart';

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

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      children: [
        //top welcome bar
        Container(
          color: myScheme.primary,
          constraints: const BoxConstraints.expand(height: 210),
          child: SafeArea(
            child: Row(
              children: [
                Container(
                  width: 200,
                  padding: const EdgeInsets.fromLTRB(20, 0, 5, 20),
                  child: Column(
                    verticalDirection: VerticalDirection.up,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          'Αναζήτησε ένα βιβλίο',
                          style: TextStyle(
                              color: myScheme.onPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w200),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Καλωσήρθες,',
                          style: TextStyle(
                            color: myScheme.onPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 42),
                  width: 110,
                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage('assets/images/landing_page.png'),
                      ),
                    ],
                    verticalDirection: VerticalDirection.up,
                  ),
                ),
              ],
            ),
          ),
        ),
        //search field
        Misc.searchBar(),
        //category items
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Misc.sectionTitle('Κατηγοριες Βιβλίων', MainAxisAlignment.start),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    children: Misc.getCategories(),
                    spacing: 10,
                    runSpacing: 2.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    Container(
      color: myScheme.primary,
      child: SafeArea(
        child: const Player(),
      ),
    ),
    Container(
      color: myScheme.primary,
      child: SafeArea(
        child: Container(
          color: myScheme.background,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: Misc.sectionTitle(
                    'Η Βιβλιοθήκη μου', MainAxisAlignment.center),
              ),
              Misc.searchBar(),
            ],
          ),
        ),
      ),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  PlState createState() => PlState();
}

class PlState extends State<Player> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  AudioCache audioCache = AudioCache(fixedPlayer: null);
  String path = 'audio/dummy.mp3';

  @override
  void initState() {
    super.initState();
    //init in here might be a problem
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        audioPlayerState = s;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();
  }

  playAudio() async {
    await audioCache.play(path);
  }

  pauseAudio() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        iconSize: 50,
        onPressed: () {
          audioPlayerState == AudioPlayerState.PLAYING ? pauseAudio() : playAudio();
        },
        icon: Icon(audioPlayerState == AudioPlayerState.PLAYING
            ? Icons.pause_rounded
            : Icons.play_arrow_rounded),
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
  onSecondary: Color.fromRGBO(49, 32, 73, 1.0),
  onSurface: Colors.white,
  onBackground: Color.fromRGBO(49, 32, 73, 0.8),
  onError: Colors.white,
  brightness: Brightness.light,
);
