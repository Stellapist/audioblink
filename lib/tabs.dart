import 'dart:ui';
import 'package:audioblink/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'misc.dart';

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
    'Ποίηση',
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Text(
          categories[i],
          style: const TextStyle(
            color: Color.fromRGBO(49, 32, 73, 0.7),
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
      ),
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
        //top welcome bar
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
                      children: getCategories(),
                      spacing: 10,
                      runSpacing: 2.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //TODO - LISTENING NOW TAB
  static Widget libraryTab() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: Misc.sectionTitle('Η Βιβλιοθήκη μου', MainAxisAlignment.center),
          ),
          Misc.searchBar(),
        ],
      ),
    );
  }

  //TODO - LIBRARY TAB
  static Widget listeningTab() {
    return const Center(
        child: Text(
      'this will be the library tab',
    ));
  }
}
