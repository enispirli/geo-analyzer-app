import 'package:dio/dio.dart';
import 'package:geo_analyzer_app/api/location_api_service.dart';
import 'package:geo_analyzer_app/api/user_api_service.dart';
import 'package:geo_analyzer_app/constants/constants.dart';
import 'package:geo_analyzer_app/cubit/create_user_cubit.dart';
import 'package:geo_analyzer_app/cubit/send_location_cubit.dart';
import 'package:geo_analyzer_app/service/geolocator_service.dart';
import 'package:geo_analyzer_app/service/location_service.dart';
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

  sl.registerSingleton<LocationApiService>(LocationApiService(sl()));
  sl.registerSingleton<LocationService>(LocationService(sl()));
  sl.registerSingleton<SendLocationCubit>(SendLocationCubit(sl()));

  sl.registerSingleton<DeviceStateUtil>(DeviceStateUtil());
  sl.registerSingleton<GeoLocatorService>(GeoLocatorService());
}

Dio createDio() {
  Dio dio = Dio(BaseOptions(baseUrl: apiBaseUrl));
  dio.options.contentType = Headers.jsonContentType;
  return dio;
}
