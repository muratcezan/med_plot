import 'package:flutter/material.dart';
import 'package:cust_plot/line.dart';

class DrawLinePainter extends CustomPainter {
  Color drawLineColor;
  Color deleteLineColor;
  double startCleanerPoint;
  List<Line> lines = [];

  DrawLinePainter({
    required this.drawLineColor,
    required this.deleteLineColor,
    required this.startCleanerPoint,
    required this.lines,
  });

  getPaint(Color color) {
    return Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = color;
  }

  getPaintFill(Color color) {
    return Paint()
      ..style = PaintingStyle.fill
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint plotPaint = getPaint(drawLineColor);
    Paint deletePaint = getPaintFill(deleteLineColor);

    // clear area
    canvas.drawRect(
      Rect.fromLTRB(0.0, 0.0, size.width, size.height),
      deletePaint,
    );

    // data line
    for (int i = 0; i < lines.length; i++) {
      Offset startLine =
          Offset(lines[i].getStartX, lines[i].getStartY + size.height / 2);
      Offset stopLine =
          Offset(lines[i].getStopX, lines[i].getStopY + size.height / 2);

      canvas.drawLine(startLine, stopLine, plotPaint);
    }

    // data cleaner
    double clearSize = (size.width / 100);
    double lastClearSize =
        clearSize - (size.width - (startCleanerPoint - clearSize));

    canvas.drawRect(
      Rect.fromLTRB(
        startCleanerPoint,
        0.0,
        (startCleanerPoint > size.width - 10
            ? lastClearSize + startCleanerPoint
            : clearSize + startCleanerPoint),
        size.height,
      ),
      deletePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
