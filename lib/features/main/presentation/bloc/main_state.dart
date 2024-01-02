part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class WorkStarting extends MainState {}

class WorkStarted extends MainState {}

class WorkStartError extends MainState {
  final String error;
  const WorkStartError({required this.error});
}

class WorkEnding extends MainState {}

class WorkEnded extends MainState {}

class WorkEndError extends MainState {
  final String error;
  const WorkEndError({required this.error});
}
