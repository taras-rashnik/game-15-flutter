import 'package:game15/model/cbrick.dart';

import 'geometry/cpoint.dart';
import 'geometry/crect.dart';
import 'geometry/csize.dart';

class CField {
  final CRect rect;
  final int cols;
  final int rows;
  final List<CBrick> bricks;

  CField._({this.rect, this.cols, this.rows, this.bricks});

  CField({this.rect, this.cols, this.rows, int bricksNumber})
      : this.bricks = _generateBricks(rect, cols, rows, bricksNumber, 0.8);

  static _generateBricks(CRect rect, int cols, int rows, int number, double brickScale) {
    var cellSize = CSize(
      width: rect.width / cols,
      height: rect.height / rows,
    );

    return List<CBrick>.generate(number, (i) {
      int col = i % cols;
      int row = i ~/ cols;

      return CBrick(
        index: i,
        rect: CRect(
          center: CPoint(
            x: rect.left + col * cellSize.width + cellSize.width / 2,
            y: rect.top + row * cellSize.height + cellSize.height / 2,
          ),
          size: CSize(
            width: cellSize.width * brickScale,
            height: cellSize.height * brickScale,
          ),
        ),
        cornerRadius: cellSize.width/6,
      );
    });
  }

  CSize get size => rect.size;

  double get width => size.width;

  double get height => size.height;

  CSize get cellSize => CSize(width: size.width / cols, height: size.height / rows);

  double get left => rect.left;

  double get right => rect.right;

  double get top => rect.top;

  double get bottom => rect.bottom;
}
