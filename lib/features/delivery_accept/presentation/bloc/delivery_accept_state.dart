part of 'delivery_accept_bloc.dart';

class DeliveryAcceptState extends Equatable {
  const DeliveryAcceptState();

  @override
  List<Object> get props => [];
}

class DeliveryAcceptInitial extends DeliveryAcceptState {}

class DeliverAcepting extends DeliveryAcceptState {}

class DeliverAcepted extends DeliveryAcceptState {}

class DeliverAceptError extends DeliveryAcceptState {}
