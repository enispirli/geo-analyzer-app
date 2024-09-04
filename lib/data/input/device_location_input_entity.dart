import 'package:equatable/equatable.dart';

class DeviceLocationInputEntity extends Equatable {
  final int deviceId;
  final double lat;
  final double lon;

  const DeviceLocationInputEntity(
      {required this.deviceId, required this.lat, required this.lon});

  @override
  List<Object?> get props => [deviceId, lat, lon];

  factory DeviceLocationInputEntity.fromJson(Map<String, dynamic> map) =>
      DeviceLocationInputEntity(
        deviceId: map['deviceId'],
        lat: map['lat'],
        lon: map['lon'],
      );

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'lat': lat,
        'lon': lon,
      };
}
