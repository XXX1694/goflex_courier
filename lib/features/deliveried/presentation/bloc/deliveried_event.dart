part of 'deliveried_bloc.dart';

abstract class DeliveriedEvent extends Equatable {
  const DeliveriedEvent();

  @override
  List<Object> get props => [];
}

class Delivered extends DeliveriedEvent {
  final int id;
  final int distance;
  const Delivered({
    required this.id,
    required this.distance,
  });
}

class ResetA extends DeliveriedEvent {}
