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

//Content of the application
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      home: const Tabs(),
    );
  }
}

//Content of tabbed activity
class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    //Search Tab
    Container(
      color: myScheme.primary,
      child: const SafeArea(
        child: SearchTab(),
      ),
    ),
    //Listening now Tab
    Container(
      color: myScheme.primary,
      child: const SafeArea(
        child: PlayerTab(),
      ),
    ),
    //Library Tab
    Container(
      color: myScheme.primary,
      child: const SafeArea(
        child: LibraryTab(),
      ),
    ),
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
        backgroundColor: myScheme.background,
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

//Content of the SEARCH tab
class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myScheme.background,
      child: Column(
        children: [
          //top welcome bar
          Container(
            color: myScheme.primary,
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
          //search field
          Misc.searchBar(),
          //category items
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Misc.sectionTitle(
                    'Κατηγοριες Βιβλίων', MainAxisAlignment.start),
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
    );
  }
}

//Content of the PLAYING NOW tab
class PlayerTab extends StatefulWidget {
  const PlayerTab({Key? key}) : super(key: key);

  @override
  _PlayerTabState createState() => _PlayerTabState();
}

class _PlayerTabState extends State<PlayerTab> {
  String dropdownValue = 'Κεφάλαιο 1';

  var chapters = [
    'Κεφάλαιο 1',
    'Κεφάλαιο 2',
    'Κεφάλαιο 3',
    'Κεφάλαιο 4',
    'Κεφάλαιο 5'
  ];

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
  Widget build(BuildContext context) {
    return Container(
      color: myScheme.background,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
          margin: const EdgeInsets.only(top: 20),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: myScheme.secondary,
                    width: 2.0,
                    style: BorderStyle.solid),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: myScheme.secondary,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: myScheme.primaryContainer,
            ),
            value: dropdownValue,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: myScheme.primaryContainer,
            ),
            items: chapters.map((String chapters) {
              return DropdownMenuItem(
                value: chapters,
                child: Text(chapters),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
        ),
        Misc.sectionTitle('Book Title', MainAxisAlignment.center),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Book Author',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w200,
                color: myScheme.primary),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              iconSize: 85,
              color: myScheme.secondary,
              onPressed: () {
                previousTrack();
              },
              icon: const Icon(Icons.skip_previous_rounded),
            ),
            Container(
              decoration: BoxDecoration(
                  color: myScheme.primary, shape: BoxShape.circle),
              child: IconButton(
                iconSize: 110,
                color: myScheme.background,
                onPressed: () {
                  audioPlayerState == AudioPlayerState.PLAYING
                      ? pauseAudio()
                      : playAudio();
                },
                icon: Icon(audioPlayerState == AudioPlayerState.PLAYING
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded),
              ),
            ),
            IconButton(
              iconSize: 85,
              color: myScheme.secondary,
              onPressed: () {
                nextTrack();
              },
              icon: const Icon(Icons.skip_next_rounded),
            ),
          ]),
        ),
      ]),
    );
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

  previousTrack() async {
    //todo change this to playing previous chapter
    audioPlayer.seek(const Duration(seconds: 0));
    await audioCache.play(path);
  }

  nextTrack() async {
    //todo change this to playing next chapter
    audioPlayer.seek(const Duration(seconds: 0));
    await audioCache.play(path);
  }
}

//Content of the LIBRARY tab
class LibraryTab extends StatefulWidget {
  const LibraryTab({Key? key}) : super(key: key);

  @override
  _LibraryTabState createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myScheme.background,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40),
            child:
                Misc.sectionTitle('Η Βιβλιοθήκη μου', MainAxisAlignment.center),
          ),
          Misc.searchBar(),
        ],
      ),
    );
  }
}

const ColorScheme myScheme = ColorScheme(
  primary: Color.fromRGBO(49, 32, 73, 1.0),
  primaryContainer: Color.fromRGBO(49, 32, 73, 0.7),
  secondary: Color.fromRGBO(255, 137, 0, 1.0),
  secondaryContainer: Color.fromRGBO(255, 137, 0, 0.7),
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
