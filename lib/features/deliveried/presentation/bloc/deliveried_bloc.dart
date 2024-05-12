import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/features/deliveried/data/repositories/repo.dart';

part 'deliveried_event.dart';
part 'deliveried_state.dart';

class DeliveriedBloc extends Bloc<DeliveriedEvent, DeliveriedState> {
  final DeliveriedRepo repo;
  DeliveriedBloc({
    required this.repo,
    required DeliveriedState deliveriedState,
  }) : super(DeliveriedInitial()) {
    on<Delivered>(
      (event, emit) async {
        emit(Deliviring());
        try {
          final res = await repo.deliveried(
            event.id,
            event.distance,
            event.code,
          );
          if (res == 201) {
            emit(Deliviringed());
          } else {
            emit(
              DelivirError(),
            );
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(DelivirError());
        }
      },
    );
    on<ResetA>(
      (event, emit) async {
        emit(DeliveriedInitial());
      },
    );
    on<SendCode>(
      (event, emit) async {
        await repo.sendCode(id: event.id);
      },
    );
  }
}
