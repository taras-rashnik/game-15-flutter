import 'package:game15/model/geometry/csegment1d.dart';

import 'cpoint.dart';
import 'csize.dart';

class CRect {
  final CPoint center;
  final CSize size;

  const CRect({this.center, this.size});

  CRect shift(double dx, double dy) =>
      CRect(center: center.shift(dx, dy), size: size);

  get left => center.x - size.width / 2;

  get right => center.x + size.width / 2;

  get top => center.y - size.height / 2;

  get bottom => center.y + size.height / 2;

  get width => size.width;

  get height => size.height;

  CSegment1d get verticalSegment => CSegment1d(top, bottom);

  CSegment1d get horizontalSegment => CSegment1d(left, right);

  bool isInside(CPoint fieldPoint) {
    return verticalSegment.isInside(fieldPoint.y) &&
        horizontalSegment.isInside(fieldPoint.x);
  }

  @override
  bool operator ==(other) {
    if (other is! CRect) return false;
    final CRect typedOther = other;
    return center == typedOther.center && size == typedOther.size;
  }

  @override
  int get hashCode => center.hashCode ^ size.hashCode;

  @override
  String toString() => 'CRect(center: $center, size: $size)';

  CRect rotateRight90() => CRect(center: center.rotateRight90(), size: size.rotateRight90());

  CRect rotateLeft90() => CRect(center: center.rotateLeft90(), size: size.rotateLeft90());
}
