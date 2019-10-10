import 'package:equatable/equatable.dart';

abstract class FieldState extends Equatable {
  const FieldState();
}

class InitialFieldState extends FieldState {
  @override
  List<Object> get props => [];
}
