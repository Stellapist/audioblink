import 'dart:ui';

import 'package:audioblink/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';

class Misc {
  //CATEGORY BUTTONS

  //SECTION TITLE
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
                fontSize: 24,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
