import 'package:equatable/equatable.dart';

class UserInfoInputEntity extends Equatable {
  final String username;
  final String deviceName;
  final String deviceImei;

  const UserInfoInputEntity(
      {required this.username,
      required this.deviceName,
      required this.deviceImei});

  @override
  List<Object?> get props => [username, deviceName, deviceImei];

  factory UserInfoInputEntity.fromJson(Map<String, dynamic> map) =>
      UserInfoInputEntity(
        username: map['username'],
        deviceName: map['deviceName'],
        deviceImei: map['deviceImei'],
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'deviceName': deviceName,
        'deviceImei': deviceImei,
      };
}
