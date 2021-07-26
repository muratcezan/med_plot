// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/physics.dart';

import 'package:cust_plot/line.dart';
import 'package:cust_plot/draw_line_painter.dart';

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

  List<Line> lines =
      List.generate(125, (index) => Line(startX: index.toDouble()));

  late AnimationController _animationController;

  _callTimerEvent(Timer timer) {
    print("call _callTimerEvent");
  }

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
    // _animationController.dispose();
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
            builder: (_, constraints) {
              // // print(counter);
              if (counter < lines.length - 1) {
                counter++;
              } else {
                counter = 1;
              }

              // _lineController.setLines = lines;
              // _lineController._updateLines(counter);
              // lines = _lineController.getLines;
              // print("running");

              return Container(
                width: 1000, //constraints.widthConstraints().maxWidth,
                height: 1000, //constraints.heightConstraints().maxHeight / 2,
                color: Colors.black,
                child: CustomPaint(
                  painter: DrawLinePainter(
                    deleteLineColor: Colors.black,
                    drawLineColor: Colors.green,
                    startCleanerPoint: 996.0,
                  ),
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