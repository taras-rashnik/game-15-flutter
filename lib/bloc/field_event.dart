import 'package:equatable/equatable.dart';

abstract class FieldEvent extends Equatable {
  const FieldEvent();
}

class NewGameEvent extends FieldEvent {
  @override
  List<Object> get props => null;
}

class MoveBrickEvent extends FieldEvent {
  final double dx;
  final double dy;

  MoveBrickEvent(this.dx, this.dy);

  @override
  List<Object> get props => [dx, dy];
}

class SelectBrickEvent extends FieldEvent {
  final double x;
  final double y;

  SelectBrickEvent(this.x, this.y);

  @override
  List<Object> get props => [x, y];
}

class DeselectBrickEvent extends FieldEvent {
  @override
  List<Object> get props => null;
}
