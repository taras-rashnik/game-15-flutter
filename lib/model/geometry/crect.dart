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
}
