import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'qr_scaner_event.dart';
part 'qr_scaner_state.dart';

class QrScanerBloc extends Bloc<QrScanerEvent, QrScanerState> {
  QrScanerBloc() : super(QrScanerInitial()) {
    on<QrScanerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
