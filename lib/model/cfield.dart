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
      : this.bricks = _generateBricks(rect, cols, rows, bricksNumber, 0.99);

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
        cornerRadius: cellSize.width / 12,
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

  List<CBrick> findRightNeighbours(CBrick newBrick) {
    final neighbours = <CBrick>[];
    for (var brick in bricks) {
      if (brick.index == newBrick.index) continue;
      if (brick.center.x <= newBrick.center.x) continue;

      if (newBrick.right > brick.left) {
        var rightSegment = newBrick.rightSegment.toVertical1d();
        var leftSegment = brick.leftSegment.toVertical1d();

        if (rightSegment.overlaps(leftSegment)) neighbours.add(brick);
      }
    }

    return neighbours;
  }

  List<CBrick> findTopRightNeighbours(CBrick newBrick) {
    final neighbours = <CBrick>[];
    for (var brick in bricks) {
      if (brick.index == newBrick.index) continue;
      if (brick.center.x <= newBrick.center.x) continue;

      if (newBrick.right > brick.left) {
        var topRightSegment = newBrick.topRightSegment.rotateRight45();
        var bottomLeftSegment = brick.bottomLeftSegment.rotateRight45();

        if (!topRightSegment
            .toVertical1d()
            .overlaps(bottomLeftSegment.toVertical1d())) continue;

        if (topRightSegment.begin.x > bottomLeftSegment.begin.x)
          neighbours.add(brick);
      }
    }

    return neighbours;
  }

  List<CBrick> findBottomRightNeighbours(CBrick newBrick) {
    final neighbours = <CBrick>[];
    for (var brick in bricks) {
      if (brick.index == newBrick.index) continue;
      if (brick.center.x <= newBrick.center.x) continue;

      if (newBrick.right > brick.left) {
        var bottomRightSegment = newBrick.bottomRightSegment.rotateLeft45();
        var topLeftSegment = brick.topLeftSegment.rotateLeft45();

        if (!bottomRightSegment
            .toVertical1d()
            .overlaps(topLeftSegment.toVertical1d())) continue;

        if (bottomRightSegment.begin.x > topLeftSegment.begin.x)
          neighbours.add(brick);
      }
    }

    return neighbours;
  }

  CField _shiftBrickRight(int index, double distance) {
    assert(distance > 0);

    final newBrick = bricks[index].shift(distance, 0);
    if (newBrick.rect.right > rect.right) return this;

    var newField = CField._(
      rect: rect,
      cols: cols,
      rows: rows,
      bricks: bricks.map((b) => index == b.index ? newBrick : b).toList(),
    );

    // push other bricks right
    final rightNeighbours = findRightNeighbours(newBrick);
    for (var rightNeighbour in rightNeighbours) {
      final tmpField =
          newField._shiftBrickRight(rightNeighbour.index, distance);

      if (tmpField == newField) return this;
      newField = tmpField;
    }

    // push other bricks right and up
    final topRightNeighbours = findTopRightNeighbours(newBrick);
    for (var topRightNeighbour in topRightNeighbours) {
      final tmpField = newField
          ._shiftBrickRight(topRightNeighbour.index, distance)
          ._shiftBrickUp(topRightNeighbour.index, distance);

      if (tmpField == newField) return this;
      newField = tmpField;
    }

    // push other bricks right and down
    final bottomRightNeighbours = findBottomRightNeighbours(newBrick);
    for (var bottomRightNeighbour in bottomRightNeighbours) {
      final tmpField = newField
          ._shiftBrickRight(bottomRightNeighbour.index, distance)
          ._shiftBrickDown(bottomRightNeighbour.index, distance);

      if (tmpField == newField) return this;
      newField = tmpField;
    }

    return newField;
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

  CField rotateRight90() => CField._(
        rect: rect.rotateRight90(),
        cols: rows,
        rows: cols,
        bricks: bricks.map((b) => b.rotateRight90()).toList(),
      );

  CField rotateLeft90() => CField._(
        rect: rect.rotateLeft90(),
        cols: rows,
        rows: cols,
        bricks: bricks.map((b) => b.rotateLeft90()).toList(),
      );

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
