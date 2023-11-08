import 'package:flutter/material.dart';

class AppColors {
  // static Color appColor = fromHex('#4f4539');
  static Color appColor = fromHex('#faba73');
  static Color backgroundColor = fromHex('#1f1c16');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
