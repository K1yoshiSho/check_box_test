import 'package:check_box/src/utils/colors.dart';
import 'package:flutter/material.dart';

class CheckBoxComponent extends StatefulWidget {
  final bool value;
  final ColorsEnum enumColor;
  final ValueChanged<ColorsEnum?> onChange;
  final double duration;
  final Function(Animation<double>) checkBuilder;

  const CheckBoxComponent({
    Key? key,
    required this.value,
    required this.onChange,
    required this.checkBuilder,
    required this.duration,
    required this.enumColor,
  }) : super(key: key);

  @override
  State<CheckBoxComponent> createState() => _CheckBoxComponentState();
}

class _CheckBoxComponentState extends State<CheckBoxComponent> with SingleTickerProviderStateMixin {
  late bool _checkedBox;
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _checkedBox = widget.value;

    _controller = AnimationController(
      value: _checkedBox ? 1.0 : 0.0,
      duration: Duration(milliseconds: widget.duration.toInt()),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant CheckBoxComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkedBox = widget.value;
    if (_checkedBox) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  _toggle() {
    setState(() {
      _checkedBox = !_checkedBox;
      (_checkedBox) ? widget.onChange(widget.enumColor) : widget.onChange(null);
      if (_checkedBox) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.duration = Duration(milliseconds: widget.duration.toInt());

    return GestureDetector(
      onTap: _toggle,
      child: widget.checkBuilder(_controller),
    );
  }
}
