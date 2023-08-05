import 'dart:math';
import 'package:check_box/src/components/app_button.dart';
import 'package:check_box/src/components/checkbox_painter.dart';
import 'package:check_box/src/components/checkbox.dart';
import 'package:rxdart/rxdart.dart';
import 'package:check_box/src/models/model.dart';
import 'package:check_box/src/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CheckBoxModel> _checkBoxList = [];
  ColorsEnum? _currentColor;
  final BehaviorSubject<double> _sliderValue = BehaviorSubject<double>.seeded(200);

  @override
  void initState() {
    _checkBoxList.add(
      CheckBoxModel(
        enumColor: ColorsEnum.red,
        color: Colors.red,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _sliderValue.close();
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
                    _checkBoxList.addAll(
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
                    _checkBoxList.clear();
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
        stream: _sliderValue.stream,
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
                          children: _checkBoxList.map((CheckBoxModel check) {
                            bool isChecked = check.enumColor == _currentColor;

                            return SizedBox(
                              height: 25,
                              width: 25,
                              child: CheckBoxComponent(
                                value: isChecked,
                                enumColor: check.enumColor,
                                duration: duration,
                                onChange: (newVal) {
                                  setState(() {
                                    _currentColor = newVal;
                                  });
                                },
                                checkBuilder: (Animation<double> animation) {
                                  return CustomPaint(
                                    painter: CheckBoxPainter(
                                      animation: animation,
                                      checkValue: check.enumColor == _currentColor,
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
                        onChanged: (value) => _sliderValue.add(value),
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
