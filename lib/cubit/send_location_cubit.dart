import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_analyzer_app/cubit/send_location_state.dart';
import 'package:geo_analyzer_app/data/input/device_location_input_entity.dart';
import 'package:geo_analyzer_app/data/output/device_location_output_entity.dart';
import 'package:geo_analyzer_app/service/location_service.dart';

class SendLocationCubit extends Cubit<SendLocationState> {
  final LocationService _locationService;

  SendLocationCubit(this._locationService)
      : super(const SendLocationInitialState());

  Future<void> sendDeviceLocation(DeviceLocationInputEntity input) async {
    emit(const SendLocationLoadingState());

    try {
      DeviceLocationOutputEntity deviceLocationOutputEntity =
          await _locationService.sendDeviceLocation(input);

      emit(SendLocationSuccessState(deviceLocationOutputEntity));
    } on Exception catch (e) {
      emit(SendLocationErrorState(e.toString()));
    }
  }
}
