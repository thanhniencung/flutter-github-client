import 'package:flutter/material.dart' show Color;

class HexColor extends Color {
  static int getColorFromHex(String hexColor) {
    if (hexColor.isEmpty) {
      hexColor = '#333333';
    }
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return int.parse("0x$hexColor");
    }
  }

  HexColor(final String hexColor) : super(getColorFromHex(hexColor));
}
