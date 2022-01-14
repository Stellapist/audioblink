import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
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
                      margin: const EdgeInsets.only(left: 20),
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
                                  fontWeight: FontWeight.w600),
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
              padding: const EdgeInsets.all(30),
              child: const TextField(
                style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(49, 32, 73, 1.0),),
                decoration: InputDecoration(
                prefixIcon:  Icon(Icons.search, color: Color.fromRGBO(49, 32, 73, 1.0),),
                hintText: "Αναζήτηση",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(255, 137, 0, 1.0), width: 2.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(49, 32, 73, 1.0), width: 2.0, style: BorderStyle.solid,),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, style: BorderStyle.solid,),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
