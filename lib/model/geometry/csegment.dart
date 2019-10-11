import 'cpoint.dart';
import 'csegment1d.dart';

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

  CSegment1d toVertical1d() => CSegment1d(begin.y, end.y);

  CSegment1d toHorizontal1d() => CSegment1d(begin.x, end.x);
}
