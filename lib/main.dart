import 'package:cust_plot/draw_line_painter.dart';
import 'package:cust_plot/line.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late double sinus;
  double counter = 0;

  List<Line> lines = [];

  late AnimationController _animationController;

  void firstRun() {
    for (int i = 0; i < 1000; i++) {
      lines.add(Line(
        startX: i.toDouble(),
        startY: 0.0,
        stopX: (i + 1).toDouble(),
        stopY: 0.0,
      ));
    }
  }

  @override
  void initState() {
    firstRun();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _updateLines(double counter) {
    sinus = math.sin(counter * 0.1) * 200.0;

    double transportX = lines[counter.toInt() - 1].getStopX;
    double transportY = lines[counter.toInt() - 1].getStopY;

    lines[counter.toInt()].setStartX = transportX;
    lines[counter.toInt()].setStartY = transportY;
    lines[counter.toInt()].setStopX = counter.toDouble();
    lines[counter.toInt()].setStopY = sinus;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
          color: Colors.grey[600],
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) {
              if (counter < 999) {
                counter++;
              } else {
                counter = 1;
              }
              _updateLines(counter);

              return Container(
                width: 1000, //constraints.widthConstraints().maxWidth,
                height: 500, //constraints.heightConstraints().maxHeight / 2,
                color: Colors.black,
                child: CustomPaint(
                  painter: DrawLinePainter(
                      deleteLineColor: Colors.black,
                      drawLineColor: Colors.green,
                      startCleanerPoint: counter,
                      lines: lines),
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
