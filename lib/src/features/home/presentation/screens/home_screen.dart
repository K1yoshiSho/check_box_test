import 'dart:math';
import 'package:check_box/src/features/home/models/model.dart';
import 'package:check_box/src/features/home/presentation/components/app_button.dart';
import 'package:check_box/src/features/home/presentation/components/checkbox.dart';
import 'package:check_box/src/features/home/presentation/components/checkbox_painter.dart';
import 'package:check_box/src/features/home/presentation/screens/model_home.dart';
import 'package:check_box/src/services/app_model.dart';
import 'package:check_box/src/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenModel _homeScreenModel;

  @override
  void initState() {
    _homeScreenModel = createModel(context, () => HomeScreenModel());
    super.initState();
  }

  @override
  void dispose() {
    _homeScreenModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 4,
              child: AppButton(
                onPressed: () {
                  setState(() {
                    _homeScreenModel.checkBoxList.addAll(
                      List.generate(
                        10,
                        (index) {
                          ColorsEnum enumColor = ColorsEnum.values[Random().nextInt(ColorsEnum.values.length)];
                          return CheckBoxModel(
                            enumColor: enumColor,
                            color: getColorFromEnum(enumColor),
                          );
                        },
                      ),
                    );
                  });
                },
                title: "Добавить +10",
                isOutline: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: AppButton(
                onPressed: () {
                  setState(() {
                    _homeScreenModel.checkBoxList.clear();
                  });
                },
                title: "Очистить",
                isOutline: true,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _homeScreenModel.sliderValue.stream,
        builder: (context, snapshot) {
          final double duration = snapshot.data ?? 100;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ListView(
                      primary: true,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: _homeScreenModel.checkBoxList.map((CheckBoxModel check) {
                            bool isChecked = check.enumColor == _homeScreenModel.currentColor;

                            return SizedBox(
                              height: 25,
                              width: 25,
                              child: CheckBoxComponent(
                                value: isChecked,
                                enumColor: check.enumColor,
                                duration: duration,
                                onChange: (newVal) {
                                  setState(() {
                                    _homeScreenModel.currentColor = newVal;
                                  });
                                },
                                checkBuilder: (Animation<double> animation) {
                                  return CustomPaint(
                                    painter: CheckBoxPainter(
                                      animation: animation,
                                      checkValue: check.enumColor == _homeScreenModel.currentColor,
                                      color: check.color,
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Slider.adaptive(
                        value: duration,
                        min: 100,
                        max: 1000,
                        onChanged: (value) => _homeScreenModel.sliderValue.add(value),
                        divisions: 1000,
                        label: "${duration.toInt()} ms",
                      ),
                      Text("Скорость анимации: ${duration.toInt()} ms")
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
