part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class StartWork extends MainEvent {}

class EndWork extends MainEvent {}
