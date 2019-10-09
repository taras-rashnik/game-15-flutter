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

  @override
  bool operator ==(other) {
    if (other is! CSegment1d) return false;
    final CSegment1d typedOther = other;
    return begin == typedOther.begin && end == typedOther.end;
  }

  @override
  int get hashCode => begin.hashCode ^ end.hashCode;

  @override
  String toString() => 'CSegment1d(${begin?.toStringAsFixed(1)}, ${end?.toStringAsFixed(1)})';
}
