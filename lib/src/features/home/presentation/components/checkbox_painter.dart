import 'package:flutter/material.dart';

/// [CheckBoxPainter] is a custom painter that draws the check box
class CheckBoxPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final bool checkValue;

  CheckBoxPainter({
    required this.animation,
    required this.checkValue,
    required this.color,
  }) : super(repaint: animation);

  static const double checkerIconSize = 18;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset centerPoint = Offset(size.width / 2, size.height / 2);

    /// [Draw the border circle]
    final Paint initialCircle = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(centerPoint, size.width / 2, initialCircle);

    /// [Check mark]
    Path checkPath = Path();
    checkPath.moveTo(size.width * 0.25, size.height * 0.5);
    checkPath.lineTo(size.width * 0.41, size.height * 0.65);
    checkPath.lineTo(size.width * 0.75, size.height * 0.33);

    Paint checkPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    checkPaint.color = Colors.white.withOpacity(1.0);
    checkPaint.strokeCap = StrokeCap.round;
    checkPaint.strokeJoin = StrokeJoin.round;

    /// [Fill color paint]
    final fillPaint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    /// [Draw the fill circle]
    canvas.drawCircle(centerPoint, size.width / 2 * animation.value, fillPaint);

    /// [Draw the check mark]
    if (animation.value >= 0.5) {
      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(CheckBoxPainter oldDelegate) {
    return true;
  }
}
