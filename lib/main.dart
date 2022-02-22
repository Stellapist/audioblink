import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio/just_audio.dart';

import 'misc.dart';

void main() {
  runApp(const MyApp());
}

//Content of the application
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
  var chapters = [
    'Κεφάλαιο 1',
    'Κεφάλαιο 2',
    'Κεφάλαιο 3',
    'Κεφάλαιο 4',
    'Κεφάλαιο 5'
  ];

  String dropdownValue = 'Κεφάλαιο 1';
  AudioPlayer audioPlayer = AudioPlayer();
  String path = 'assets/audio/rick.mp3';
  late Stream<DurationState> _durationState;
  final _labelLocation = TimeLabelLocation.below;
  final _labelType = TimeLabelType.totalTime;
  final _thumbRadius = 8.0;
  final _labelPadding = 5.0;
  final _barHeight = 4.0;
  final _barCapShape = BarCapShape.round;
  final _thumbCanPaintOutsideBar = true;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        audioPlayer.positionStream,
        audioPlayer.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    _init();
  }

  Future<void> _init() async {
    try {
      await audioPlayer.setAsset(path);
    } catch (e) {
      debugPrint('An error occurred $e');
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myScheme.background,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
          margin: const EdgeInsets.only(top: 30),
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
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Misc.sectionTitle('Book Title', MainAxisAlignment.center)),
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
          margin: const EdgeInsets.symmetric(vertical: 40),
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
              child: _playButton(),
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
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
            child: _progressBar()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: myScheme.primary, shape: BoxShape.circle),
              child: _playSpeed(),
            ),
            Container(
              decoration: BoxDecoration(
                  color: myScheme.primary, shape: BoxShape.circle),
              child: _playSpeed(),
            ),
          ],

        ),
      ]),
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(28.0),
            width: 70.0,
            height: 70.0,
            child: CircularProgressIndicator(
                color: myScheme.background, strokeWidth: 6),
          );
        } else if (playing != true) {
          return IconButton(
              icon: Icon(
                Icons.play_arrow_rounded,
                color: myScheme.background,
              ),
              iconSize: 110.0,
              onPressed: audioPlayer.play);
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: Icon(Icons.pause_rounded, color: myScheme.background),
            iconSize: 110.0,
            onPressed: audioPlayer.pause,
          );
        } else {
          return IconButton(
            icon: Icon(Icons.stop_rounded, color: myScheme.background),
            iconSize: 110.0,
            onPressed: () => audioPlayer.seek(Duration.zero),
          );
        }
      },
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;

        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (duration) {
            audioPlayer.seek(duration);
          },
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          barHeight: _barHeight,
          baseBarColor: myScheme.surface,
          progressBarColor: myScheme.secondaryContainer,
          bufferedBarColor: myScheme.onSurface,
          thumbColor: myScheme.secondary,
          thumbGlowColor: myScheme.secondary,
          barCapShape: _barCapShape,
          thumbRadius: _thumbRadius,
          thumbCanPaintOutsideBar: _thumbCanPaintOutsideBar,
          timeLabelLocation: _labelLocation,
          timeLabelType: _labelType,
          timeLabelTextStyle:
              TextStyle(color: myScheme.primary, fontWeight: FontWeight.w600),
          timeLabelPadding: _labelPadding,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playSpeed() {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 40.0,
            height: 40.0,
            child: CircularProgressIndicator(
                color: myScheme.background, strokeWidth: 6),
          );
        } else if (playing != true) {
          return IconButton(
              icon: const Text('1x'),
              iconSize: 50.0,
              onPressed: audioPlayer.play);
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Text('2x'),
            iconSize: 50.0,
            onPressed: audioPlayer.pause,
          );
        } else {
          return IconButton(
            icon: const Text('3x'),
            iconSize: 50.0,
            onPressed: () => audioPlayer.seek(Duration.zero),
          );
        }
      },
    );
  }

  previousTrack() {}

  nextTrack() {}
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

//Misc
class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });

  final Duration progress;
  final Duration buffered;
  final Duration? total;
}

const ColorScheme myScheme = ColorScheme(
  primary: Color.fromRGBO(49, 32, 73, 1.0),
  primaryContainer: Color.fromRGBO(33, 24, 45, 0.7019607843137254),
  secondary: Color.fromRGBO(255, 137, 0, 1.0),
  secondaryContainer: Color.fromRGBO(255, 137, 0, 0.7),
  surface: Color.fromRGBO(194, 194, 194, 1.0),
  background: Colors.white,
  error: Colors.redAccent,
  onPrimary: Colors.white,
  onSecondary: Color.fromRGBO(49, 32, 73, 1.0),
  onSurface: Color.fromRGBO(255, 137, 0, 0.25),
  onBackground: Color.fromRGBO(49, 32, 73, 0.8),
  onError: Colors.white,
  brightness: Brightness.light,
);
