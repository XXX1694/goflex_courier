import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/features/order_history/data/repositories/repo.dart';
import 'package:goflex_courier/features/orders/data/models/order_model.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final OrderArchiveRepository repo;
  OrderHistoryBloc({
    required this.repo,
    required OrderHistoryState orderHistoryState,
  }) : super(OrderHistoryInitial()) {
    on<GetOrderArchive>(
      (event, emit) async {
        emit(GettingOrdersH());
        try {
          List<OrderModel> res = await repo.getOrders();
          if (res.isNotEmpty) {
            emit(GotOrdersH(orders: res));
          } else {
            emit(GetOrdersErrorH());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(GetOrdersErrorH());
        }
      },
    );
  }
}
