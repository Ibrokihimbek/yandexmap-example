import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:yandex_mapexample/models/lat_long.dart';

part 'lat_long_event.dart';

part 'lat_long_state.dart';

class LatLongBloc extends Bloc<LatLongEvent, GetLatLongState> {
  LatLongBloc() : super(const GetLatLongState()) {
    on<GetLatLongEvent>(_fetchCurrentLocation);
  }

  LatLong? latLong;

  Location location = Location();

  bool serviceEnabled = false;
  PermissionStatus permissionGranted = PermissionStatus.denied;

  Future<void> _fetchCurrentLocation(
    GetLatLongEvent event,
    Emitter<GetLatLongState> emit,
  ) async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    emit(
      state.copyWith(latLongStatus: GetLatLongStatus.loading),
    );
    LocationData locationData = await location.getLocation();
    await Future.delayed(const Duration(seconds: 3));
    latLong = LatLong(
      lat: locationData.latitude!,
      long: locationData.longitude!,
    );
    if (latLong != null) {
      emit(
        state.copyWith(
            latLongStatus: GetLatLongStatus.success, latLong: latLong),
      );
    } else {
      emit(
        state.copyWith(latLongStatus: GetLatLongStatus.error),
      );
    }
  }
}
