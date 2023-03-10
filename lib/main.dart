import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio/just_audio.dart';
import 'package:duration_picker/duration_picker.dart';

import 'misc.dart';
import 'bookItem.dart';

//stella

void main() {
  runApp(const MyApp());
}

//APPLICATION CONTENT
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

//TABBED ACTIVITY CONTENT
class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

//STATE OF TABBED ACTIVITY
class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;

  //Build Tabbed Activity
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

  //Tabs Content
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

  //On Item Tapped Method
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

//SEARCH TAB CONTENT
class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

//SEARCH TAB STATE
class _SearchTabState extends State<SearchTab> {
  String selectedCategory = '';
  String? searchItem = '';
  final _controller = TextEditingController();

  //TODO MAYBE MAKE IT GLOBAL PUBLIC
  final player = AudioPlayer();

  //TEMP STATIC BOOK ITEMS
  List<String> images = [
    'assets/images/rick_shoe.jpg',
    'assets/images/rick_shoe.jpg',
    'assets/images/rick_shoe.jpg',
    'assets/images/rick_shoe.jpg',
    'assets/images/rick_shoe.jpg',
    'assets/images/rick_shoe.jpg'
  ];
  List<String> titles = [
    'Never gonna',
    'Never gonna',
    'Never gonna',
    'Never gonna',
    'Never gonna',
    'Never gonna'
  ];
  List<String> authors = [
    'Rick Astley',
    'Rick Astley',
    'Rick Astley',
    'Rick Astley',
    'Rick Astley',
    'Rick Astley'
  ];
  List<String> readers = [
    'Give U. Up',
    'Give U. Up',
    'Give U. Up',
    'Give U. Up',
    'Give U. Up',
    'Give U. Up'
  ];
  List<String> audios = [
    'assets/audio/rick.mp3',
    'assets/audio/rick.mp3',
    'assets/audio/rick.mp3',
    'assets/audio/rick.mp3',
    'assets/audio/rick.mp3',
    'assets/audio/rick.mp3'
  ];

  List<String> durations = [
    '23:41:12',
    '23:41:12',
    '23:41:12',
    '23:41:12',
    '23:41:12',
    '23:41:12'
  ];

  //Build
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myScheme.background,
      child: Column(
        children: [
          //top welcome bar
          searchItem == '' && selectedCategory == ''
              ? Container(
                  color: myScheme.primary,
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        padding: const EdgeInsets.fromLTRB(20, 45, 5, 20),
                        child: Column(
                          verticalDirection: VerticalDirection.up,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Καλωσήρθες!',
                              style: TextStyle(
                                color: myScheme.onPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
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
                              image:
                                  AssetImage('assets/images/landing_page.png'),
                            ),
                          ],
                          verticalDirection: VerticalDirection.up,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          color: myScheme.primary,
                          iconSize: 35,
                          onPressed: () {
                            setState(() {
                              searchItem = '';
                              selectedCategory = '';
                              _controller.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Container(
                          child: Misc.sectionTitle(
                              selectedCategory, MainAxisAlignment.center),
                        ),
                        IconButton(
                          color: myScheme.background,
                          iconSize: 35,
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ]),
                ),
          //search field
          searchBar(),
          //category items
          searchItem == '' && selectedCategory == ''
              ? Expanded(
                  child: getCategoryButtons(),
                )
              : Expanded(child: getBookItems()),
        ],
      ),
    );
  }

  //Search For User Input Method
  void searchForInput() {
    setState(() {
      selectedCategory = 'Αναζήτηση';
    });
  }

  //get book items individually according to search criteria
  Widget getBookItems() {
    return ListView.builder(
        itemCount: booksList().length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return booksList().elementAt(index);
        });
  }

  List<Widget> booksList() {
    List<Widget> booksList = <Widget>[];
    for (var i = 0; i < images.length; i++) {
      booksList.add(Column(
        children: [
          GestureDetector(
            onTap: () {
              //TODO ADD BOOK INFO
            },
            child: BookItem.getBookItem(images[i], titles[i], authors[i],
                readers[i], audios[i], durations[i]),
          ),
          Divider(
            color: i + 1 < images.length
                ? myScheme.primaryContainer
                : myScheme.background,
            thickness: 0.5,
            indent: 30,
            height: 20,
            endIndent: 30,
          )
        ],
      ));
    }
    return booksList;
  }

  //WIDGETS
  //Search Bar
  Widget searchBar() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: TextFormField(
          controller: _controller,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: myScheme.primary,
              fontSize: 22),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: myScheme.primaryContainer,
            ),
            hintText: "Αναζήτηση",
            hintStyle: TextStyle(
              color: myScheme.primaryContainer,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: myScheme.primary,
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
          onChanged: (String? val) {
            searchItem = val;
          },
          onEditingComplete: searchForInput),
    );
  }

  //Category Buttons
  Widget getCategoryButtons() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: 10),
          child:
              Misc.sectionTitle('Κατηγοριες Βιβλίων', MainAxisAlignment.start),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: categoryButtons().length,
            itemBuilder: (BuildContext context, int index) {
              return categoryButtons().elementAt(index);
            },
          ),
        ),
      ],
    );
  }

  //Category Buttons Content
  List<Widget> categoryButtons() {
    List<Widget> categoryButtons = <Widget>[];
    for (var i = 0; i < Variables.categories.length; i++) {
      categoryButtons.add(Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              selectedCategory = Variables.categories[i];
            });
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            side: BorderSide(
              color: myScheme.primary,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              Variables.categories[i],
              style: TextStyle(
                color: myScheme.primaryContainer,
                fontWeight: FontWeight.w400,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ));
    }
    return categoryButtons;
  }
}

//PLAYER TAB CONTENT
class PlayerTab extends StatefulWidget {
  const PlayerTab({Key? key}) : super(key: key);

  @override
  _PlayerTabState createState() => _PlayerTabState();
}

//PLAYER TAB STATE
class _PlayerTabState extends State<PlayerTab> {
  //Variables
  AudioPlayer audioPlayer = AudioPlayer();
  bool initialized = false;
  int hr = 0, mins = 0, secs = 0, sleep = 0, sleepInMins = 0;
  late Timer sleepTimer;
  String dropdownValue = 'Κεφάλαιο 1',
      currentIndication = '1x',
      path = 'assets/audio/rick.mp3';
  double firstSpeed = 1.0,
      secondSpeed = 1.5,
      thirdSpeed = 2.0,
      currentSpeed = 1.0;
  late Stream<DurationState> _durationState;
  final _labelLocation = TimeLabelLocation.below;
  final _labelType = TimeLabelType.totalTime;
  final _thumbRadius = 8.0;
  final _labelPadding = 5.0;
  final _barHeight = 4.0;
  final _barCapShape = BarCapShape.round;
  final _thumbCanPaintOutsideBar = true;

  //Player Functions
  @override
  void initState() {
    super.initState();
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
    initialized = true;
    try {
      await audioPlayer.setAsset(path);
      audioPlayer.setSpeed(firstSpeed);
    } catch (e) {
      debugPrint('An error occurred $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    //TODO THIS DISPOSE DELETES PREVIOUS AUDIOPLAYER SO THAT A NEW ONE IS MADE. MAKE IT SO THAT IT DOESN'T CREATE A NEW ONE IF THERE IS ALREADY ONE CREATED AND DELETE BELOW 'DISPOSE'
    audioPlayer.dispose();
  }

  //Handle Sleep Method
  Future<void> handleSleep() async {
    Duration sec = audioPlayer.position;
    double vol = audioPlayer.volume;
    while (audioPlayer.volume > 0) {
      audioPlayer.setVolume(audioPlayer.volume - 0.01);
      await Future.delayed(const Duration(milliseconds: 25));
    }
    audioPlayer.pause();
    audioPlayer.seek(sec);
    audioPlayer.setVolume(vol);
  }

  //Build
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myScheme.background,
      child: Stack(children: [
        Column(children: [
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
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: myScheme.primaryContainer,
              ),
              value: dropdownValue,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: myScheme.primaryContainer,
              ),
              items: Variables.chapters.map((String chapters) {
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
              margin: const EdgeInsets.only(top: 10),
              child: Misc.sectionTitle('Book Title', MainAxisAlignment.center)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Book Author',
              style: TextStyle(
                  fontSize: 20,
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
                icon: const Tooltip(
                    message: "previous",
                    child: Icon(Icons.skip_previous_rounded)),
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
                icon: const Tooltip(
                    message: "next", child: Icon(Icons.skip_next_rounded)),
              ),
            ]),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
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
                child: IconButton(
                  iconSize: 50,
                  color: myScheme.background,
                  onPressed: () async {
                    if (sleep == 0) {
                      var resDur = await showDurationPicker(
                        context: context,
                        initialTime: const Duration(minutes: 30),
                        baseUnit: BaseUnit.minute,
                      );
                      if (resDur != null) {
                        setState(() {
                          sleep = -1;
                        });
                        int hr = resDur.inHours;
                        int mins = (resDur.inMinutes - (hr * 60));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: hr > 0
                              ? Text(
                                  'Sleep timer set for $hr hours and $mins minutes.',
                                  style: TextStyle(
                                      color: myScheme.background, fontSize: 15),
                                )
                              : Text(
                                  'Sleep timer set for $mins minutes.',
                                  style: TextStyle(
                                      color: myScheme.background, fontSize: 15),
                                ),
                          duration: const Duration(seconds: 1),
                          backgroundColor: myScheme.primary,
                        ));
                        sleep = resDur.inSeconds;
                        startTimer();
                      } else {
                        sleepTimer.cancel();
                      }
                    } else {
                      setState(() {
                        sleep = 0;
                        (sleepTimer.cancel());
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Timer cancelled.',
                          style: TextStyle(
                              color: myScheme.background, fontSize: 15),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: myScheme.primary,
                      ));
                    }
                  },
                  icon: sleep != 0
                      ? const Tooltip(
                          message: "cancel timer",
                          child: Icon(Icons.close_rounded))
                      : const Tooltip(
                          message: "timer", child: Icon(Icons.bedtime_rounded)),
                ),
              ),
            ],
          ),
        ]),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
            color: sleep > 0 ? myScheme.secondary : myScheme.background,
            child: hr > 0
                ? Text(
                    'Sleep timer ends in $hr hours, $mins minutes and $secs seconds.',
                    style: TextStyle(color: myScheme.background, fontSize: 15),
                  )
                : mins > 0
                    ? Text(
                        'Sleep timer ends in $mins minutes and $secs seconds.',
                        style:
                            TextStyle(color: myScheme.background, fontSize: 15),
                      )
                    : Text(
                        'Sleep timer ends in $secs seconds.',
                        style:
                            TextStyle(color: myScheme.background, fontSize: 15),
                      ),
          ),
        ),
      ]),
    );
  }

  //WIDGETS
  //Play Button
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
              icon: Tooltip(
                message: "play",
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: myScheme.background,
                ),
              ),
              iconSize: 110.0,
              onPressed: audioPlayer.play);
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: Tooltip(
                message: "pause",
                child: Icon(Icons.pause_rounded, color: myScheme.background)),
            iconSize: 110.0,
            onPressed: audioPlayer.pause,
          );
        } else {
          return IconButton(
            icon: Tooltip(
                message: "stop",
                child: Icon(Icons.stop_rounded, color: myScheme.background)),
            iconSize: 110.0,
            onPressed: () => audioPlayer.seek(Duration.zero),
          );
        }
      },
    );
  }

  //Progress Bar
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
          timeLabelTextStyle: TextStyle(
              color: myScheme.primary,
              fontWeight: FontWeight.w400,
              fontSize: 18),
          timeLabelPadding: _labelPadding,
        );
      },
    );
  }

  //Play Speed Button
  StreamBuilder<PlayerState> _playSpeed() {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        return Tooltip(
          child: IconButton(
              icon: Text(
                currentIndication,
                style: TextStyle(
                  color: myScheme.background,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
              iconSize: 50.0,
              onPressed: () => {
                    if (audioPlayer.speed == thirdSpeed)
                      {currentSpeed = firstSpeed, currentIndication = '1x'}
                    else if (audioPlayer.speed == secondSpeed)
                      {currentSpeed = thirdSpeed, currentIndication = '3x'}
                    else
                      {currentSpeed = secondSpeed, currentIndication = '2x'},
                    setState(() {
                      audioPlayer.setSpeed(currentSpeed);
                    })
                  }),
          message: "play speed",
        );
      },
    );
  }

  //Previous Track Button
  void previousTrack() {}

  //Next Track Button
  void nextTrack() {}

  //Start Timer Button
  void startTimer() {
    sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (sleep > 0) {
          hr = sleep ~/ 3600;
          mins = (sleep ~/ 60 - (hr * 60));
          secs = (sleep - ((hr * 3600) + (mins * 60)));
          sleep--;
        } else {
          handleSleep();
          sleepTimer.cancel();
        }
      });
    });
  }
}

//LIBRARY TAB CONTENT
class LibraryTab extends StatefulWidget {
  const LibraryTab({Key? key}) : super(key: key);

  @override
  _LibraryTabState createState() => _LibraryTabState();
}

//LIBRARY TAB STATE
class _LibraryTabState extends State<LibraryTab> {
  //Build
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
          Container(
            padding: const EdgeInsets.all(25),
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: myScheme.primary,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: myScheme.primaryContainer,
                ),
                hintText: "Αναζήτηση",
                hintStyle: TextStyle(
                  color: myScheme.primaryContainer,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: myScheme.primary,
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
            ),
          ),
        ],
      ),
    );
  }
}

//DURATION STATE
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

//COLOR SCHEME
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
