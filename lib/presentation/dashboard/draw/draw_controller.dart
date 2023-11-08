import 'package:flutter/material.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:painter/painter.dart';

class DrawController extends GetxController {
  RxBool finished = false.obs;
  RxBool isEraseMode = false.obs;

  PainterController painterController = newController();

  static PainterController newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.green;
    controller.drawColor = Colors.red;
    controller.eraseMode = false;

    return controller;
  }
}
