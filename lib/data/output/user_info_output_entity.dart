import 'package:equatable/equatable.dart';

class UserInfoOutputEntity extends Equatable {
  final int userId;
  final int deviceId;

  const UserInfoOutputEntity({
    required this.userId,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [userId, deviceId];

  factory UserInfoOutputEntity.fromJson(Map<String, dynamic> map) =>
      UserInfoOutputEntity(
        userId: map['userId'],
        deviceId: map['deviceId'],
      );
}
