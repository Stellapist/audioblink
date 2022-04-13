import 'package:audioblink/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';

class Misc {
  //CATEGORY BUTTONS

  //Section Title
  static Widget sectionTitle(String title, MainAxisAlignment mainAxisAlignment) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            title,
            style: TextStyle(
                color: myScheme.primary,
                fontSize: 26,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

class Variables {
  static const List<String> categories = [
    'Λογοτεχνία',
    'Ιστορία',
    'Φιλοσοφία',
    'Τέχνη',
    'Επιστήμη',
    'Πολιτική',
    'Αρχαία Γραμματεία',
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

  static const List<String> chapters = [
  'Κεφάλαιο 1',
  'Κεφάλαιο 2',
  'Κεφάλαιο 3',
  'Κεφάλαιο 4',
  'Κεφάλαιο 5'
  ];
}
