import 'package:check_box/src/features/home/models/model.dart';
import 'package:check_box/src/services/app_model.dart';
import 'package:check_box/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

/// [HomeScreenModel] - model for `HomeScreen`, where init and dispose fields.
class HomeScreenModel extends AppModel {
  /// `Fields`
  final List<CheckBoxModel> checkBoxList = [];
  ColorsEnum? currentColor;
  late final BehaviorSubject<double> sliderValue;

  @override
  void initState(BuildContext context) {
    sliderValue = BehaviorSubject<double>.seeded(200);
    checkBoxList.add(
      CheckBoxModel(
        enumColor: ColorsEnum.red,
        color: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    sliderValue.close();
  }
}
