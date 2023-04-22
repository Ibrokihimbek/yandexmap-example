part of 'lat_long_bloc.dart';

class GetLatLongState extends Equatable {
  final GetLatLongStatus latLongStatus;
  final LatLong? latLong;

  const GetLatLongState({
    this.latLong,
    this.latLongStatus = GetLatLongStatus.initial,
  });

  GetLatLongState copyWith({
    GetLatLongStatus? latLongStatus,
    LatLong? latLong,
  }) {
    return GetLatLongState(
      latLong: latLong ?? this.latLong,
      latLongStatus: latLongStatus ?? this.latLongStatus,
    );
  }

  @override
  List<Object?> get props => [
        latLong,
        latLongStatus,
      ];
}

enum GetLatLongStatus { initial, loading, success, error }

extension GetLatLongStatusX on GetLatLongStatus {
  bool get isInitial => this == GetLatLongStatus.initial;

  bool get isLoading => this == GetLatLongStatus.loading;

  bool get isSuccess => this == GetLatLongStatus.success;

  bool get isError => this == GetLatLongStatus.error;
}
