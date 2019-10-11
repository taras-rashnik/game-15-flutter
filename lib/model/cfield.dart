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

  CSize get size => rect.size;

  double get width => size.width;

  double get height => size.height;

  CSize get cellSize => CSize(size.width / cols, size.height / rows);

  double get left => rect.left;

  double get right => rect.right;

  double get top => rect.top;

  double get bottom => rect.bottom;

  static _generateBricks(
    CRect rect,
    int cols,
    int rows,
    int number,
    double brickScale,
  ) {
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

  CField shiftBrick(int index, double dx, double dy) {
    final count = 10;
    var ddx = dx / count;
    var ddy = dy / count;

    CField oldField = this;
    for (int i = 0; i < count; i++) {
      CField newField = oldField._shiftBrickALittle(index, ddx, ddy);
      if (oldField == newField) {
        break;
      }
      oldField = newField;
    }

    return oldField;
  }

  CField _shiftBrickALittle(int index, double dx, double dy) {
    CField newField = this;
    if (dx > 0) {
      newField = newField._shiftBrickRight(index, dx);
    } else if (dx < 0) {
      newField = newField._shiftBrickLeft(index, -dx);
    }

    if (dy > 0) {
      newField = newField._shiftBrickDown(index, dy);
    } else if (dy < 0) {
      newField = newField._shiftBrickUp(index, -dy);
    }

    return newField;
  }

  CField _shiftBrickRight(int index, double distance) {
    assert(distance > 0);

    final newBrick = bricks[index].shift(distance, 0);
    if(newBrick.rect.right > rect.right) return this;
    
    var newBricks =
        bricks.map((b) => index == b.index ? newBrick : b).toList();

    return CField._(rect: rect, cols: cols, rows: rows, bricks: newBricks);
  }

  CField _shiftBrickLeft(int index, double distance) {
    return this
        .rotateRight90()
        .rotateRight90()
        ._shiftBrickRight(index, distance)
        .rotateRight90()
        .rotateRight90();
  }

  CField _shiftBrickDown(int index, double distance) {
    return this
        .rotateRight90()
        ._shiftBrickRight(index, distance)
        .rotateLeft90();
  }

  CField _shiftBrickUp(int index, double distance) {
    return this
        .rotateLeft90()
        ._shiftBrickRight(index, distance)
        .rotateRight90();
  }

  CField rotateRight90() {
    var newBricks = bricks.map((b) => b.rotateRight90()).toList();

    return CField._(
      rect: rect.rotateRight90(),
      cols: rows,
      rows: cols,
      bricks: newBricks,
    );
  }

  CField rotateLeft90() {
    return this.rotateRight90().rotateRight90().rotateRight90();
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
