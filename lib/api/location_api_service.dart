import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:geo_analyzer_app/data/input/device_location_input_entity.dart';
import 'package:geo_analyzer_app/data/output/device_location_output_entity.dart';

part 'location_api_service.g.dart';

@RestApi()
abstract class LocationApiService {
  factory LocationApiService(Dio dio) = _LocationApiService;

  @POST('/location')
  Future<HttpResponse<DeviceLocationOutputEntity>> sendLocation(
      @Body() DeviceLocationInputEntity input);
}
