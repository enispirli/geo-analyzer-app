import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:geo_analyzer_app/data/input/user_info_input_entity.dart';
import 'package:geo_analyzer_app/data/output/user_info_output_entity.dart';

part 'user_api_service.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  @POST('/user')
  Future<HttpResponse<UserInfoOutputEntity>> createUser(
      @Body() UserInfoInputEntity input);
}
