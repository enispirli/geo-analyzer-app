import 'package:dio/dio.dart';
import 'package:geo_analyzer_app/api/user_api_service.dart';
import 'package:geo_analyzer_app/data/input/user_info_input_entity.dart';
import 'package:geo_analyzer_app/data/output/user_info_output_entity.dart';

class UserService {
  final UserApiService _userApiService;

  UserService(this._userApiService);

  Future<UserInfoOutputEntity> saveUserAndDeviceInfo(
      UserInfoInputEntity input) async {
    try {
      final httpResponse = await _userApiService.createUser(input);
      return httpResponse.data;
    } on DioException catch (e) {
      print('Error create user: $e');
      throw Exception('Failed to create user');
    }
  }
}
