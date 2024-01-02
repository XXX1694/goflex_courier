import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'map_target_event.dart';
part 'map_target_state.dart';

class MapTargetBloc extends Bloc<MapTargetEvent, MapTargetState> {
  MapTargetBloc() : super(MapTargetInitial()) {
    on<MapTargetEvent>((event, emit) {});
  }
}
