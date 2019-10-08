import 'dart:math';

class CSegment1d {
  final double begin;
  final double end;

  CSegment1d({this.begin, this.end});

  bool isInside(double x) {
    var a = min(begin, end);
    var b = max(begin, end);
    return a <= x && x <= b;
  }
}
