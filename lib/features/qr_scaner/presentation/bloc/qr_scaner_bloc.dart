import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'qr_scaner_event.dart';
part 'qr_scaner_state.dart';

class QrScanerBloc extends Bloc<QrScanerEvent, QrScanerState> {
  QrScanerBloc() : super(QrScanerInitial()) {
    on<QrScanerEvent>((event, emit) {});
  }
}
