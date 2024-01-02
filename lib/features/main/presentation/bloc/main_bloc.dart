import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/features/main/data/repositories/main_repo.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository repo;
  MainBloc({
    required this.repo,
    required MainState mainState,
  }) : super(MainInitial()) {
    on<StartWork>(
      (event, emit) async {
        emit(WorkStarting());
        try {
          final res = await repo.startWork();
          if (res == 201) {
            emit(WorkStarted());
          } else {
            emit(
              WorkStartError(error: 'Код ошибки: $res'),
            );
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(WorkStartError(error: e.toString()));
        }
      },
    );
    on<EndWork>(
      (event, emit) async {
        emit(WorkEnding());
        try {
          final res = await repo.endWork();
          if (res == 201) {
            emit(WorkEnded());
          } else {
            emit(
              WorkEndError(error: 'Код ошибки: $res'),
            );
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(WorkEndError(error: e.toString()));
        }
      },
    );
  }
}
