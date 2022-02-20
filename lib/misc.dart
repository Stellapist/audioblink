import 'dart:ui';

import 'package:audioblink/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';

class Misc {
  //CATEGORY BUTTONS
  static List<OutlinedButton> getCategories() {
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
        onPressed: (//TODO add onPressed
            ) {
          debugPrint(categories[i]);
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: BorderSide(
            color: myScheme.primary,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Text(
            categories[i],
            style: TextStyle(
              color: myScheme.primaryContainer,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
      ));
    }
    return categoryButtons;
  }

  //SEARCH BAR
  static Widget searchBar() {
    return Container(
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
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
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
      ),
    );
  }

  //SECTION TITLE
  static Widget sectionTitle(String title, MainAxisAlignment alignment) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            title,
            style: TextStyle(
                color: myScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
