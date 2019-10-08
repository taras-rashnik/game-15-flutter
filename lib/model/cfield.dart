


import 'geometry/crect.dart';
import 'geometry/csize.dart';

class CField {
  final CRect rect;
  final int cols;
  final int rows;

  CField({this.rect, this.cols, this.rows});

  CSize get size => rect.size;

  double get width => size.width;

  double get height => size.height;

  CSize get cellSize => CSize(width: size.width / cols, height: size.height / rows);

  double get left => rect.left;

  double get right => rect.right;

  double get top => rect.top;

  double get bottom => rect.bottom;
}
