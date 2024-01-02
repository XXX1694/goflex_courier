part of 'deliveried_bloc.dart';

abstract class DeliveriedEvent extends Equatable {
  const DeliveriedEvent();

  @override
  List<Object> get props => [];
}

class Delivered extends DeliveriedEvent {
  final int id;
  const Delivered({required this.id});
}

class ResetA extends DeliveriedEvent {}
