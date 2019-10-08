import 'package:game15/model/geometry/cpoint.dart';
import 'package:game15/model/geometry/csize.dart';

import 'geometry/crect.dart';

class CBrick {
  final int index;
  final CRect rect;
  final double cornerRadius;

  CBrick({this.index, this.rect, this.cornerRadius});

  CPoint get center => rect.center;

  CSize get size => rect.size;

  double get width => size.width;

  double get height => size.height;
}
