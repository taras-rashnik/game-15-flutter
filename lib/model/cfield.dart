import 'package:collection/collection.dart';
import 'package:game15/model/cbrick.dart';

import 'geometry/cpoint.dart';
import 'geometry/crect.dart';
import 'geometry/csize.dart';

class CField {
  final CRect rect;
  final int cols;
  final int rows;
  final List<CBrick> bricks;

  final _listEquality = const ListEquality<CBrick>();

  const CField._({this.rect, this.cols, this.rows, this.bricks});

  CField({this.rect, this.cols, this.rows, int bricksNumber})
      : this.bricks = _generateBricks(rect, cols, rows, bricksNumber, 0.8);

  CField clone() => CField._(
      rect: rect.clone(),
      cols: cols,
      rows: rows,
      bricks: bricks.map((b) => b.clone()).toList());

  CField shiftBrick(int index, double dx, double dy) {
    var newBricks = bricks
        .map((b) => index == b.index ? b.shift(dx, dy) : b.clone())
        .toList();

    return CField._(
        rect: rect.clone(), cols: cols, rows: rows, bricks: newBricks);
  }

  CSize get size => rect.size;

  double get width => size.width;

  double get height => size.height;

  CSize get cellSize => CSize(size.width / cols, size.height / rows);

  double get left => rect.left;

  double get right => rect.right;

  double get top => rect.top;

  double get bottom => rect.bottom;

  static _generateBricks(
      CRect rect, int cols, int rows, int number, double brickScale) {
    var cellSize = CSize(
      rect.width / cols,
      rect.height / rows,
    );

    return List<CBrick>.generate(number, (i) {
      int col = i % cols;
      int row = i ~/ cols;

      return CBrick(
        index: i,
        rect: CRect(
          center: CPoint(
            // TODO: rect.center.shift()
            rect.left + col * cellSize.width + cellSize.width / 2,
            rect.top + row * cellSize.height + cellSize.height / 2,
          ),
          size: cellSize * brickScale,
        ),
        cornerRadius: cellSize.width / 6,
      );
    });
  }

  CBrick findBrick(CPoint fieldPoint) {
    return bricks.firstWhere(
      (b) => b.rect.isInside(fieldPoint),
      orElse: () => null,
    );
  }

  CField tryMoveBrick(CBrick brick, double dx, double dy) {
    return shiftBrick(brick.index, dx, dy);
  }

  @override
  bool operator ==(other) {
    if (other is! CField) return false;
    final CField typedOther = other;
    return cols == typedOther.cols &&
        rows == typedOther.rows &&
        rect == typedOther.rect &&
        _listEquality.equals(bricks, typedOther.bricks);
  }

  @override
  int get hashCode =>
      cols.hashCode ^
      rows.hashCode ^
      rect.hashCode ^
      _listEquality.hash(bricks);

  @override
  String toString() => 'CField(rect: $rect, cols: $cols, rows: $rows)';
}
