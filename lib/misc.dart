import 'dart:ui';
import 'package:audioblink/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class Misc {

  //SEARCH BAR
  static Widget searchBar() {
    return Container(
      padding: const EdgeInsets.all(25),
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
    );
  }

  static Widget sectionTitle(String title, MainAxisAlignment alignment) {
    return Row(
        mainAxisAlignment: alignment,
        children: [Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            title,
            style: const TextStyle(
                color: Color.fromRGBO(49, 32, 73, 1.0),
                fontSize: 24,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}