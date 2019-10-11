import 'dart:math';

class CSegment1d {
  final double begin;
  final double end;

  const CSegment1d(this.begin, this.end);

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
  String toString() =>
      'CSegment1d(${begin?.toStringAsFixed(1)}, ${end?.toStringAsFixed(1)})';

  bool overlaps(CSegment1d otherSegment) {
    if (begin < otherSegment.begin && otherSegment.begin <= end) return true;
    if (begin < otherSegment.end && otherSegment.end <= end) return true;

    if (otherSegment.begin < begin && begin <= otherSegment.end) return true;
    if (otherSegment.begin < end && end <= otherSegment.end) return true;

    return false;
  }
}
