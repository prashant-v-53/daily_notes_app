import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast(message) {
  Fluttertoast.cancel();
  if (message != null) {
    Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
