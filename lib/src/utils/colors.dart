import 'package:flutter/material.dart';

/// [ColorsEnum] - enum for colors.
enum ColorsEnum {
  red,
  green,
  blue,
}

/// [getColorFromEnum] - returns color from enum.
Color getColorFromEnum(ColorsEnum color) {
  return switch (color) {
    ColorsEnum.red => Colors.red,
    ColorsEnum.green => Colors.green,
    ColorsEnum.blue => Colors.blue,
  };
}
