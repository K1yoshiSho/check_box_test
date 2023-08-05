import 'package:check_box/src/utils/colors.dart';
import 'package:flutter/material.dart';

/// [CheckBoxModel] - model for checkbox.
class CheckBoxModel {
  final ColorsEnum enumColor;
  final Color color;

  CheckBoxModel({
    required this.enumColor,
    required this.color,
  });
}
