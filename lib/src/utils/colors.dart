import 'package:flutter/material.dart';

enum ColorsEnum {
  red,
  green,
  blue,
}

Color getColorFromEnum(ColorsEnum color) {
  switch (color) {
    case ColorsEnum.red:
      return Colors.red;
    case ColorsEnum.green:
      return Colors.green;
    case ColorsEnum.blue:
      return Colors.blue;
  }
}
