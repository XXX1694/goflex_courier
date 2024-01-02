part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {}

class GettingOrdersH extends OrderHistoryState {}

class GotOrdersH extends OrderHistoryState {
  final List<OrderModel> orders;
  const GotOrdersH({required this.orders});
}

class GetOrdersErrorH extends OrderHistoryState {}
