import 'cpoint.dart';

class CSegment {
  final CPoint begin;
  final CPoint end;

  const CSegment({this.begin, this.end});

  @override
  bool operator ==(other) {
    if (other is! CSegment) return false;
    final CSegment typedOther = other;
    return begin == typedOther.begin && end == typedOther.end;
  }

  @override
  int get hashCode => begin.hashCode ^ end.hashCode;

  @override
  String toString() => 'CSegment(begin: $begin, end: $end)';
}