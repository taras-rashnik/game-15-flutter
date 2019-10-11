import 'package:game15/model/geometry/cpoint.dart';
import 'package:game15/model/geometry/csize.dart';

import 'geometry/crect.dart';
import 'geometry/csegment.dart';

class CBrick {
  final int index;
  final CRect rect;
  final double cornerRadius;

  const CBrick({this.index, this.rect, this.cornerRadius});

  CBrick shift(double dx, double dy) => CBrick(
      index: index, rect: rect.shift(dx, dy), cornerRadius: cornerRadius);

  CPoint get center => rect.center;
  CSize get size => rect.size;

  double get width => size.width;
  double get height => size.height;

  double get left => rect.left;
  double get right => rect.right;
  double get top => rect.top;
  double get bottom => rect.bottom;

  CSegment get rightSegment => CSegment(begin: CPoint(right, top), end: CPoint(right, bottom));
  CSegment get leftSegment => CSegment(begin: CPoint(left, top), end: CPoint(left, bottom));

  CBrick rotateRight90() {
    return CBrick(
        index: index, rect: rect.rotateRight90(), cornerRadius: cornerRadius);
  }

  CBrick rotateLeft90() {
    return CBrick(
        index: index, rect: rect.rotateLeft90(), cornerRadius: cornerRadius);
  }

  @override
  bool operator ==(other) {
    if (other is! CBrick) return false;
    final CBrick typedOther = other;
    return index == typedOther.index &&
        rect == typedOther.rect &&
        cornerRadius == typedOther.cornerRadius;
  }

  @override
  int get hashCode => index.hashCode ^ rect.hashCode ^ cornerRadius.hashCode;

  @override
  String toString() =>
      'CBrick(index: $index, rect: $rect, cornerRadius: $cornerRadius)';
}
