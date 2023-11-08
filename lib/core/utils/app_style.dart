import 'package:flutter/material.dart';
import 'package:notes_app/core/app_export.dart';

class Appstyle {
  static List<Color> cardsColor = [
    AppColors.backgroundColor,
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.amber,
    Colors.green,
    Colors.grey,
    Colors.blue,
    Colors.blueGrey,
  ];

  static List<String> backgroundImage = [
    "",
    AppImage.background1,
    AppImage.background2,
    AppImage.background3,
    AppImage.background4,
    AppImage.background5,
    AppImage.background6,
    AppImage.background7,
    AppImage.background8,
    AppImage.background9,
  ];

  static TextStyle mainTitle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle mainContent = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
  static TextStyle dateTime = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}
