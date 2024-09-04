import 'package:dio/dio.dart';
import 'package:geo_analyzer_app/api/location_api_service.dart';
import 'package:geo_analyzer_app/data/input/device_location_input_entity.dart';
import 'package:geo_analyzer_app/data/output/device_location_output_entity.dart';

class LocationService {
  final LocationApiService _locationApiService;

  LocationService(this._locationApiService);

  Future<DeviceLocationOutputEntity> sendDeviceLocation(
      DeviceLocationInputEntity input) async {
    try {
      final httpResponse = await _locationApiService.sendLocation(input);
      return httpResponse.data;
    } on DioException catch (e) {
      print('Error create user: $e');
      throw Exception('Failed to create user');
    }
  }
}
