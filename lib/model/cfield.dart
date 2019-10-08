import 'package:game15/geometry/crect.dart';
import 'package:game15/geometry/csize.dart';

class CField {
  final CRect rect;
  final int cols;
  final int rows;

  CField({this.rect, this.cols, this.rows});

  CSize get size => rect.size;

  CSize get cellSize => CSize(width: size.width/cols, height: size.height/rows);
}