// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/physics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  List<Line> ll = [
    Line(),
  ];

  double sy = 0.0;
  double counter = 0;
  late Timer _timer;
  late double sinus;
  bool tt = false;
  // _callTimerEvent(Timer timer) {
  //   sinus = math.sin(counter * 0.1) * 100.0;
  //   // print("Sinus = " + sinus.toString());
  //   if (counter < 75) {
  //     counter++;
  //     print("Arttir");
  //   } else {
  //     tt = true;
  //     counter = 1;
  //     print("Tamamlandi");
  //   }
  //   double transportX = ll[counter.toInt() - 1].getStopX;
  //   double transportY = ll[counter.toInt() - 1].getStopY;
  //   print("Transport X = " + transportX.toString());
  //   print("Transport Y = " + transportY.toString());
  //   // if (counter > 2) {
  //   //   _timer.cancel();
  //   // }
  //   setState(() {
  //     if (ll.length > 75) {
  //       // ll.removeAt(counter.toInt());
  //       print("SILINDI");
  //     }
  //     if (!tt) {
  //       ll.insert(
  //         counter.toInt(),
  //         Line(
  //           startX: transportX,
  //           startY: transportY,
  //           stopX: counter.toDouble(),
  //           stopY: sinus.toDouble(),
  //         ),
  //       );
  //     } else {
  //       ll[counter.toInt()].setStartX = transportX;
  //       ll[counter.toInt()].setStartY = transportY;
  //       ll[counter.toInt()].setStopX = counter.toDouble();
  //       ll[counter.toInt()].setStopY = sinus;
  //     }
  //   });

  //   // setState(() {
  //   //   if (ll.length >= 100) {
  //   //     print("inside");
  //   //     ll.removeAt(counter.toInt());
  //   //     ll.insert(
  //   //       counter.toInt(),
  //   //       Line(
  //   //         startX: ll[counter.toInt() - 1].getStartX,
  //   //         startY: ll[counter.toInt() - 1].getStartY,
  //   //         stopX: counter,
  //   //         stopY: counter,
  //   //       ),
  //   //     );
  //   //   } else {
  //   //     print("outside!");
  //   //     ll.add(
  //   //       Line(
  //   //         startX: counter,
  //   //       ),
  //   //     );
  //   //   }
  //   // });
  // }

  // void firstRun() {
  //   for (int i = 0; i < 75; i++) {
  //     ll.add(Line(
  //       startX: i.toDouble(),
  //       startY: 0.0,
  //       stopX: 0.0,
  //       stopY: 0.0,
  //     ));
  //   }
  // }

  List<Line> lines =
      List.generate(125, (index) => Line(startX: index.toDouble()));

  late AnimationController _animationController;

  @override
  void initState() {
    // firstRun();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    // _timer = Timer.periodic(const Duration(milliseconds: 200), _callTimerEvent);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool eraserr = false;
  @override
  Widget build(BuildContext context) {
    var _lineController = LineController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
          color: Colors.grey[600],
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, __) {
              // // print(counter);
              // if (counter < lines.length - 1) {
              //   counter++;
              // } else {
              //   counter = 1;
              //   if (eraserr) {
              //     eraserr = false;
              //   } else {
              //     eraserr = true;
              //   }
              // }

              // _lineController.setLines = lines;
              // _lineController._updateLines(counter);
              // lines = _lineController.getLines;

              return Container(
                width: 1000, //constraints.widthConstraints().maxWidth,
                height: 1000, //constraints.heightConstraints().maxHeight / 2,
                color: Colors.black,
                child: CustomPaint(
                  painter: DrawLinePainter(
                      lineList: lines, erase: eraserr ? false : true),
                  size: const Size(1000, 1000),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DrawLinePainter extends CustomPainter {
  Color color;
  int counter;
  List<Line> lineList;
  bool fisrtRun = false;
  bool erase;

  DrawLinePainter({
    Key? key,
    required this.lineList,
    this.counter = 0,
    this.color = Colors.green,
    this.erase = false,
  });

  // Paint pt = Paint()
  //   ..style = PaintingStyle.stroke
  //   ..strokeWidth = 1.0
  //   ..color = Colors.blue;

  // Paint dpt = Paint()
  //   ..style = PaintingStyle.stroke
  //   ..strokeWidth = 1.0
  //   ..color = Colors.transparent;

  @override
  void paint(Canvas canvas, Size size) {
    Paint pt = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.blue;

    Paint eraser = Paint()
      ..strokeWidth = 1.0
      ..color = Colors.black;

    eraser.blendMode = BlendMode.clear;
    // canvas.saveLayer(Offset.zero & size, Paint());
    for (int i = 0; i < lineList.length; i++) {
      canvas.drawLine(
        Offset(lineList[i].getStartX, lineList[i].getStartY),
        Offset(lineList[i].getStopX, lineList[i].getStopY),
        // (erase ? eraser : pt),
        pt,
      );
    }

    _setUpdate() {
      lineList[1].setStopY = lineList[1].getStopY + 10.0;
    }
    // canvas.restore();

    // lineList.forEach((element) {
    //   try {
    //     canvas.drawLine(
    //       Offset(element.getStartX, element.getStartY),
    //       Offset(element.getStopX, element.getStopY),
    //       pt,
    //     );
    //   } catch (e) {
    //     print("PLOT BUG");
    //   }
    // });

    // for (int i = 0; i < lineList.length; i++) {
    //   // if (i < lineList.length - 5) {

    //   canvas.drawLine(
    //       Offset(lineList[i].startX.toDouble(), lineList[i].startY.toDouble()),
    //       Offset(lineList[i].stopX.toDouble(), lineList[i].stopY.toDouble()),
    //       // Offset(i.toDouble(), 0),
    //       // Offset(i.toDouble() + 1, 0),
    //       pt);
    //   // } else {
    //   //   canvas.drawLine(
    //   //       Offset(
    //   //           lineList[i].startX.toDouble(), lineList[i].startY.toDouble()),
    //   //       Offset(lineList[i].stopX.toDouble(), lineList[i].stopY.toDouble()),
    //   //       // Offset(i.toDouble(), 0),
    //   //       // Offset(i.toDouble() + 1, 0),
    //   //       ptt);
    //   // }
    // }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Line {
  double startX;
  double stopX;
  double startY;
  double stopY;
  // var color;

  // Line Constructure
  Line({
    this.startX = 0.0,
    this.stopX = 0.0,
    this.startY = 0.0,
    this.stopY = 0.0,
    // this.color,
  });

  fall() {}

  // StartX
  double get getStartX {
    return this.startX;
  }

  set setStartX(double startX) {
    this.startX = startX;
  }

  // StarY
  double get getStartY {
    return this.startY;
  }

  set setStartY(double startY) {
    this.startY = startY;
  }

  // StopX
  double get getStopX {
    return this.stopX;
  }

  set setStopX(double stopX) {
    this.stopX = stopX;
  }

  // StopY
  double get getStopY {
    return this.stopY;
  }

  set setStopY(double stopY) {
    this.stopY = stopY;
  }
}

// for Line's start and stop points
class LinePoint {
  double x;
  double y;

  // Point Constructure
  LinePoint({
    Key? key,
    required this.x,
    required this.y,
  });

  // X parameter
  set setX(double x) {
    this.x = x;
  }

  get getX {
    return this.x;
  }

  // Y parameter
  set setY(double y) {
    this.y = y;
  }

  get getY {
    return y;
  }
}

class LineController {
  late List<Line> lines;
  double sinus = 0;
  int counter = 0;
  LineController();

  _updateLines(double counter) {
    sinus = math.sin(counter * 0.1) * 200.0;
    // print(counter);

    double transportX = this.lines[counter.toInt() - 1].getStopX;
    double transportY = this.lines[counter.toInt() - 1].getStopY;
    // print("Transport X = " + transportX.toString());
    // print("Transport Y = " + transportY.toString());

    this.lines[counter.toInt()].setStartX = transportX;
    this.lines[counter.toInt()].setStartY = transportY;
    this.lines[counter.toInt()].setStopX = counter.toDouble();
    this.lines[counter.toInt()].setStopY = sinus;
  }

  set setLines(List<Line> lines) {
    this.lines = lines;
  }

  get getLines {
    return this.lines;
  }
}
