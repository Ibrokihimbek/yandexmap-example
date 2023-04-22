part of 'lat_long_bloc.dart';

abstract class LatLongEvent extends Equatable {
  const LatLongEvent();
}

class GetLatLongEvent extends LatLongEvent {

  const GetLatLongEvent();

  @override
  List<Object?> get props => [];
}

