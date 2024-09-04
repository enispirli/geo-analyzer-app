import 'package:dio/dio.dart';
import 'package:geo_analyzer_app/api/user_api_service.dart';
import 'package:geo_analyzer_app/constants/constants.dart';
import 'package:geo_analyzer_app/cubit/create_user_cubit.dart';
import 'package:geo_analyzer_app/service/user_service.dart';
import 'package:geo_analyzer_app/util/device_state_util.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  Dio dio = createDio();
  sl.registerSingleton<Dio>(dio);
  sl.registerSingleton<UserApiService>(UserApiService(sl()));
  sl.registerSingleton<UserService>(UserService(sl()));
  sl.registerSingleton<CreateUserCubit>(CreateUserCubit(sl()));
  sl.registerSingleton<DeviceStateUtil>(DeviceStateUtil());
}

Dio createDio() {
  Dio dio = Dio(BaseOptions(baseUrl: apiBaseUrl));
  dio.options.contentType = Headers.jsonContentType;
  return dio;
}
