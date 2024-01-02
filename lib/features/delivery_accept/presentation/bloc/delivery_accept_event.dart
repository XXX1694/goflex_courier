part of 'delivery_accept_bloc.dart';

abstract class DeliveryAcceptEvent extends Equatable {
  const DeliveryAcceptEvent();

  @override
  List<Object> get props => [];
}

class AcceptDelivery extends DeliveryAcceptEvent {
  final int id;
  const AcceptDelivery({required this.id});
}

class Reset extends DeliveryAcceptEvent {}
