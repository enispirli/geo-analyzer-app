import 'package:equatable/equatable.dart';
import 'package:geo_analyzer_app/data/output/device_location_output_entity.dart';

abstract class SendLocationState extends Equatable {
  const SendLocationState();

  @override
  List<Object?> get props => [];
}

class SendLocationInitialState extends SendLocationState {
  const SendLocationInitialState();
}

class SendLocationLoadingState extends SendLocationState {
  const SendLocationLoadingState();
}

class SendLocationSuccessState extends SendLocationState {
  final DeviceLocationOutputEntity deviceLocationOutputEntity;
  const SendLocationSuccessState(this.deviceLocationOutputEntity);
}

class SendLocationErrorState extends SendLocationState {
  final String? errorMessage;
  const SendLocationErrorState(this.errorMessage);
}

class SendLocationCancelState extends SendLocationState {
  const SendLocationCancelState();
}
