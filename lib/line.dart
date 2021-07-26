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
    return startX;
  }

  set setStartX(double startX) {
    this.startX = startX;
  }

  // StarY
  double get getStartY {
    return startY;
  }

  set setStartY(double startY) {
    this.startY = startY;
  }

  // StopX
  double get getStopX {
    return stopX;
  }

  set setStopX(double stopX) {
    this.stopX = stopX;
  }

  // StopY
  double get getStopY {
    return stopY;
  }

  set setStopY(double stopY) {
    this.stopY = stopY;
  }
}
