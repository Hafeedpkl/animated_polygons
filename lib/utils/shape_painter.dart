import 'dart:math' as math;
import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  ShapePainter(
      {required this.sides, required this.radius, required this.radians});
  final double sides;
  final double radius;
  final double radians;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Offset startingPoint = Offset(0, size.height / 2);
    Offset endingPoint = Offset(size.width, size.height / 2);
    // canvas.drawLine(startingPoint, endingPoint, paint);

    // Offset center = Offset(size.width / 2, size.height / 2);
    // canvas.drawCircle(center, 100, paint);

    // var path = Path();
    // path.addOval(Rect.fromCircle(
    //     center: Offset(size.width / 2, size.height / 2), radius: 100));
    // canvas.drawPath(path, paint);

    drawPolygon(sides, size, canvas, paint, radians);
  }

  drawPolygon(double sides, Size size, Canvas canvas, Paint paint, radians) {
    print(((math.pi * 2) / 4) * 2);
    var path = Path();

    var angle = (math.pi * 2) / sides;

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint =
        Offset(radius * math.cos(radians), radius * math.sin(radians));

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 1; i <= sides; i++) {
      double x = radius * math.cos(radians + angle * i) + center.dx;
      double y = radius * math.sin(radians + angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
