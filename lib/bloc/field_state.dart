import 'package:equatable/equatable.dart';
import 'package:game15/model/cfield.dart';
import 'package:game15/model/geometry/cpoint.dart';
import 'package:game15/model/geometry/crect.dart';
import 'package:game15/model/geometry/csize.dart';

class FieldState extends Equatable {
  final CField field;
  final int selectedBrickIndex;

  const FieldState(this.field, this.selectedBrickIndex);

  FieldState clone() => FieldState(field, selectedBrickIndex);

  factory FieldState.initial(CSize fieldSize) {
    return FieldState(
      CField(
        rect: CRect(
          center: CPoint.origin(),
          size: fieldSize,
        ),
        cols: 4,
        rows: 6,
        bricksNumber: 22,
      ),
      -1,
    );
  }

  @override
  List<Object> get props => [field, selectedBrickIndex];

  FieldState shiftBrick(double dx, double dy) {
    return selectedBrickIndex < 0
        ? clone()
        : FieldState(
            field.shiftBrick(selectedBrickIndex, dx, dy),
            selectedBrickIndex,
          );
  }

  FieldState deselectBrick() => FieldState(field, -1);

  FieldState selectBrick(double x, double y) {
      CPoint fieldPoint = _toFieldCoords(x, y);
      var brick = field.findBrick(fieldPoint);
      var index = brick == null ? -1 : brick.index;
      return FieldState(field, index);
  }
 
  CPoint _toFieldCoords(double x, double y) {
    return CPoint(
      x - field.size.width / 2,
      y - field.size.height / 2,
    );
  }
}
