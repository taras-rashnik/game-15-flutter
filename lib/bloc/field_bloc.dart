import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:game15/model/cfield.dart';
import 'package:game15/model/geometry/cpoint.dart';
import 'package:game15/model/geometry/crect.dart';
import 'package:game15/model/geometry/csize.dart';
import './bloc.dart';

class FieldBloc extends Bloc<FieldEvent, CField> {
  final CSize fieldSize;

  FieldBloc(this.fieldSize);

  @override
  CField get initialState {
    return CField(
      rect: CRect(
        center: CPoint.origin(),
        //size: widget.fieldSize,
        size: fieldSize,
      ),
      cols: 4,
      rows: 6,
      bricksNumber: 22,
    );
  }

  int _selectedBrickIndex = -1;

  @override
  Stream<CField> mapEventToState(
    FieldEvent event,
  ) async* {
    if (event is NewGameEvent) {
      yield initialState;
    } else if (event is MoveBrickEvent) {
      if (_selectedBrickIndex >= 0)
        yield currentState.shiftBrick(_selectedBrickIndex, event.dx, event.dy);
      else
        yield currentState;
    } else if (event is DeselectBrickEvent) {
      _selectedBrickIndex = -1;
      yield currentState;
    } else if (event is SelectBrickEvent) {
      CPoint fieldPoint = _toFieldCoords(event.x, event.y);
      var brick = currentState.findBrick(fieldPoint);
      _selectedBrickIndex = brick == null ? -1 : brick.index;
      yield currentState;
    }
  }

  CPoint _toFieldCoords(double x, double y) {
    return CPoint(
      x - fieldSize.width / 2,
      y - fieldSize.height / 2,
    );
  }
}
