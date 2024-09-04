import 'package:equatable/equatable.dart';

class DeviceLocationOutputEntity extends Equatable {
  final String country;
  final String city;
  final String district;

  const DeviceLocationOutputEntity(
      {required this.country, required this.city, required this.district});

  @override
  List<Object?> get props => [country, city, district];

  factory DeviceLocationOutputEntity.fromJson(Map<String, dynamic> map) =>
      DeviceLocationOutputEntity(
        country: map['country'],
        city: map['city'],
        district: map['district'],
      );
}
