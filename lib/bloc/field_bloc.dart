import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:game15/model/geometry/csize.dart';
import 'package:game15/model/geometry/cvector.dart';
import './bloc.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  final CSize fieldSize;

  FieldBloc(this.fieldSize);

  @override
  FieldState get initialState => FieldState.initial(fieldSize);

  CVector _lastSpeed = CVector(0, 0);

  @override
  Stream<FieldState> mapEventToState(
    FieldEvent event,
  ) async* {
    if (event is NewGameEvent) {
      yield initialState;
    } else if (event is MoveBrickEvent) {
      _lastSpeed = CVector(event.dx, event.dy);
      print("last speed: $_lastSpeed");
      yield currentState.shiftBrick(event.dx, event.dy);
    } else if (event is DeselectBrickEvent) {
      yield* inertiaMovements();
      yield currentState.deselectBrick();
    } else if (event is SelectBrickEvent) {
      yield currentState.selectBrick(event.x, event.y);
    }
  }

  Stream<FieldState> inertiaMovements() async* {
    for (int i = 0; i < 20; ++i) {
      // fake inertia move
      await Future.delayed(Duration(milliseconds: 15));
      print("fake move $i");
      var newState =
          currentState.shiftBrick(_lastSpeed.x * 5, _lastSpeed.y * 5);
      if (newState == currentState) break;
      yield newState;
    }
  }
}
