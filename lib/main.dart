import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

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
      onPressed: () {
        debugPrint(categories[i]);
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 2.0,
          color: Color.fromRGBO(49, 32, 73, 1.0),
          style: BorderStyle.solid,
        ),
      ),
      child: Text(categories[i],
          style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.8),
            fontWeight: FontWeight.w400,
            fontSize: 17,
          )),
    ));
  }
  return categoryButtons;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Sf'),
      home: Scaffold(
        body: Column(
          children: [
            Container(
              color: const Color.fromRGBO(49, 32, 73, 1.0),
              constraints: const BoxConstraints.expand(height: 210),
              child: SafeArea(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: const Text(
                              'Αναζήτησε ένα βιβλίο',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
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
                      child: Column(
                        children: const [
                          Image(
                            image: AssetImage('assets/images/landing_page.png'),
                          ),
                        ],
                        verticalDirection: VerticalDirection.up,
                      ),
                      margin: const EdgeInsets.only(left: 50),
                      width: 110,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 10),
              child: const TextField(
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(49, 32, 73, 1.0),
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(49, 32, 73, 1.0),
                  ),
                  hintText: "Αναζήτηση",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(255, 137, 0, 1.0),
                        width: 2.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(49, 32, 73, 1.0),
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
                    children: const [
                      Text(
                        'Κατηγορίες Βιβλίων',
                        style: TextStyle(
                            color: Color.fromRGBO(49, 32, 73, 1.0),
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Wrap(
                    children: getCategories(),
                    spacing: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
