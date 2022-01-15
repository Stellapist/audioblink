import 'dart:ui';
import 'package:audioblink/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

//LIST OF CATEGORIES
List<OutlinedButton> getCategories() {
  List<String> categories = [
    'Λογοτεχνία',
    'Ιστορία',
    'Φιλοσοφία',
    'Τέχνη',
    'Επιστήμη',
    'Πολιτική',
    'Αρχαία Ελληνική Γραμματεία',
    'Παιδικά',
    'Θρησκεία',
    'Κοινωνία',
    'Βιογραφία',
    'Διατροφή',
    'Υγεία',
    'Εκπαίδευση',
    'Μαγειρική',
    'Ποίηση'
  ];

  final categoryButtons = <OutlinedButton>[];
  for (var i = 0; i < categories.length; i++) {
    categoryButtons.add(OutlinedButton(
      onPressed: (
          //TODO add onPressed
          ) {
        debugPrint(categories[i]);
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: const BorderSide(
          width: 2.0,
          color: Color.fromRGBO(49, 32, 73, 1.0),
          style: BorderStyle.solid,
        ),
      ),
      child: Text(categories[i],
          style: const TextStyle(
            color: Color.fromRGBO(49, 32, 73, 0.7),
            fontWeight: FontWeight.w400,
            fontSize: 17,
          )),
    ));
  }
  return categoryButtons;
}

//THE 3 MAIN TABS
class Tabs {

  //SEARCH TAB
  static Widget searchTab() {
    return Column(
      children: [
        Container(
          color: const Color.fromRGBO(49, 32, 73, 1.0),
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
                        child: const Text(
                          'Αναζήτησε ένα βιβλίο',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w200),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          'Καλωσήρθες,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
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
        Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(49, 32, 73, 1.0),
            ),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Color.fromRGBO(49, 32, 73, 0.7),
              ),
              hintText: "Αναζήτηση",
              hintStyle: TextStyle(
                color: Color.fromRGBO(49, 32, 73, 0.7),
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(255, 137, 0, 1.0),
                    width: 2.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(255, 137, 0, 1.0),
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text(
                      'Κατηγορίες Βιβλίων',
                      style: TextStyle(
                          color: Color.fromRGBO(49, 32, 73, 1.0),
                          fontSize: 23,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Wrap(
                  children: getCategories(),
                  spacing: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //TODO - LISTENING NOW TAB
  static Widget listeningTab() {
    return const Center(child: Text('this will be the player tab',));
  }

  //TODO - LIBRARY TAB
  static Widget libraryTab() {
    return const Center(child: Text('this will be the library tab',));
  }
}