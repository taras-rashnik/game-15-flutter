import 'package:game15/model/geometry/csegment1d.dart';

import 'cpoint.dart';
import 'csize.dart';

class CRect {
  final CPoint center;
  final CSize size;

  CRect({this.center, this.size});

  get left => center.x - size.width / 2;

  get right => center.x + size.width / 2;

  get top => center.y - size.height / 2;

  get bottom => center.y + size.height / 2;

  get width => size.width;

  get height => size.height;

  CSegment1d get verticalSegment => CSegment1d(begin: top, end: bottom);

  CSegment1d get horizontalSegment => CSegment1d(begin: left, end: right);

  bool isInside(CPoint fieldPoint) {
    return verticalSegment.isInside(fieldPoint.y) && horizontalSegment.isInside(fieldPoint.x);
  }
}
