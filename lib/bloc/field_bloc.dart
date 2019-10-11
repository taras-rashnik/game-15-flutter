import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:game15/model/cfield.dart';
import 'package:game15/model/geometry/cpoint.dart';
import 'package:game15/model/geometry/crect.dart';
import 'package:game15/model/geometry/csize.dart';
import './bloc.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  final CSize fieldSize;

  FieldBloc(this.fieldSize);

  @override
  FieldState get initialState => FieldState.initial(fieldSize);

  @override
  Stream<FieldState> mapEventToState(
    FieldEvent event,
  ) async* {
    if (event is NewGameEvent) {
      yield initialState;
    } else if (event is MoveBrickEvent) {
      yield currentState.shiftBrick(event.dx, event.dy);
    } else if (event is DeselectBrickEvent) {
      yield currentState.deselectBrick();
    } else if (event is SelectBrickEvent) {
      yield currentState.selectBrick(event.x, event.y);
    }
  }
}
