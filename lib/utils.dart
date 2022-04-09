import 'package:flutter/material.dart';

class Utils {
  // ignore: unused_element
  static Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    hexColor = (hexColor.length == 6) ? "FF" + hexColor : hexColor;
    return Color(int.parse(hexColor, radix: 16));
  }

  static void showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(text)));
}



