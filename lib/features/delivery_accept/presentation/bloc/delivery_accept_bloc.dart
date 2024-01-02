import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/features/delivery_accept/data/repositories/repo.dart';

part 'delivery_accept_event.dart';
part 'delivery_accept_state.dart';

class DeliveryAcceptBloc
    extends Bloc<DeliveryAcceptEvent, DeliveryAcceptState> {
  final AcceptDeliveryRepo repo;
  DeliveryAcceptBloc({
    required this.repo,
    required DeliveryAcceptState deliveryAcceptState,
  }) : super(DeliveryAcceptInitial()) {
    on<AcceptDelivery>(
      (event, emit) async {
        emit(DeliverAcepting());
        try {
          final res = await repo.accept(event.id);
          if (res == 201) {
            emit(DeliverAcepted());
          } else {
            emit(
              DeliverAceptError(),
            );
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(DeliverAceptError());
        }
      },
    );

    on<Reset>((event, emit) async {
      emit(DeliveryAcceptInitial());
    });
  }
}
