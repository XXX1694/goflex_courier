part of 'deliveried_bloc.dart';

abstract class DeliveriedEvent extends Equatable {
  const DeliveriedEvent();

  @override
  List<Object> get props => [];
}

class Delivered extends DeliveriedEvent {
  final int id;
  final double distance;
  final int? code;
  const Delivered({
    required this.id,
    required this.distance,
    required this.code,
  });
}

class SendCode extends DeliveriedEvent {
  final int id;
  const SendCode({required this.id});
}

class ResetA extends DeliveriedEvent {}
