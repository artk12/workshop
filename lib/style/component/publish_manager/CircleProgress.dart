import 'package:flutter/material.dart';
import 'dart:math';

class CircleProgress extends CustomPainter {
  double currentProgress;
  Color color;

  CircleProgress({this.currentProgress, this.color = Colors.green});

  // final Gradient gradient = new SweepGradient(
  //   startAngle: 3 * pi / 2,
  //   endAngle: 7 * pi / 2,
  //   stops: [
  //     0.3,
  //     0.7,
  //     0.9,
  //   ],
  //   tileMode: TileMode.repeated,
  //   colors: [Color(0xff6b8f18),Color(0xffefd201),Color(0xfffe1f00)],
  // );

  @override
  void paint(Canvas canvas, Size size) {
    Paint completeArc = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeCap = StrokeCap.butt;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    // completeArc.shader = gradient.createShader(rect);
    double angle = 2 * pi * (-currentProgress / 100);
    canvas.drawArc(rect, -pi / 2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
