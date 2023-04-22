import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'lat_long_event.dart';
part 'lat_long_state.dart';

class LatLongBloc extends Bloc<LatLongEvent, LatLongState> {
  LatLongBloc() : super(LatLongInitial()) {
    on<LatLongEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
