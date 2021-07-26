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
    Size newSize = Size(size.width / 2, size.height);
    Paint plotPaint = getPaint(drawLineColor);
    Paint deletePaint = getPaintFill(deleteLineColor);

    // clear area
    canvas.drawRect(
      Rect.fromLTRB(0.0, 0.0, size.width, size.height),
      deletePaint,
    );

    // data line
    for (int i = 0; i < lines.length; i++) {
      // print(lines[i].getStartX);
      // for (double i = 0.0; i < size.width; i = i + 1) {
      Offset startLine =
          Offset(lines[i].getStartX, lines[i].getStartY + size.height / 2);
      Offset stopLine =
          Offset(lines[i].getStopX, lines[i].getStopY + size.height / 2);
      // Offset startLine = Offset(i.toDouble(), size.height / 2);
      // Offset stopLine = Offset(i.toDouble() + 1, size.height / 2);

      canvas.drawLine(startLine, stopLine, plotPaint);
    }

    double clearSize = (size.width / 100);
    double lastClearSize =
        clearSize - (size.width - (startCleanerPoint - clearSize));

    canvas.drawRect(
      Rect.fromLTRB(
        startCleanerPoint,
        0.0,
        // (size.width / 100) + startCleanerPoint,
        (startCleanerPoint > size.width - 10
            ? lastClearSize + startCleanerPoint
            : clearSize + startCleanerPoint),
        size.height / 3 * 2,
      ),
      deletePaint,
    );
    // clear line
    // Offset startLineClear = Offset(newSize.width / 10 * 9, newSize.height / 2);
    // Offset stopLineclear = Offset(newSize.width, newSize.height / 2);

    // canvas.drawLine(startLineClear, stopLineclear, deletePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


// class DrawLinePainter extends CustomPainter {
//   Color color;
//   int counter;
//   List<Line> lineList;
//   bool fisrtRun = false;
//   bool erase;

//   DrawLinePainter({
//     Key? key,
//     required this.lineList,
//     this.counter = 0,
//     this.color = Colors.green,
//     this.erase = false,
//   });

//   Paint pt = Paint()
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 1.0
//     ..color = Colors.blue;

//   Paint eraser = Paint()
//     ..strokeWidth = 1.0
//     ..color = Colors.black;

//   @override
//   void paint(Canvas canvas, Size size) {
//     eraser.blendMode = BlendMode.clear;

//     for (int i = 0; i < lineList.length; i++) {
//       canvas.drawLine(
//         Offset(lineList[i].getStartX, lineList[i].getStartY),
//         Offset(lineList[i].getStopX, lineList[i].getStopY),
//         pt,
//       );
//     }

//     lineList.forEach((element) {
//       canvas.drawLine(
//         Offset(element.getStartX, element.getStartY),
//         Offset(element.getStopX, element.getStopY),
//         pt,
//       );
//     });
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
