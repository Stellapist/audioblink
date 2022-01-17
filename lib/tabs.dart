import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'misc.dart';
import 'main.dart';

class Tabs {

  //SEARCH TAB
  static Widget searchTab() {
    return Column(
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
    );
  }

  //TODO - LISTENING NOW TAB
  static Widget listeningTab() {
    return Container(
      color: myScheme.primary,
      child: SafeArea(
        child: Container(
          color: myScheme.background,
          child: const Center(
            child: Text(
              'this will be the library tab',
            ),
          ),
        ),
      ),
    );
  }

  //LIBRARY TAB
  static Widget libraryTab() {
    return Container(
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
    );
  }
}
