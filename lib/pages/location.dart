import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_analyzer_app/cubit/send_location_cubit.dart';
import 'package:geo_analyzer_app/cubit/send_location_state.dart';
import 'package:geo_analyzer_app/data/input/device_location_input_entity.dart';
import 'package:geo_analyzer_app/data/output/device_location_output_entity.dart';
import 'package:geo_analyzer_app/injection_container.dart';
import 'package:geo_analyzer_app/service/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  final int deviceId;

  const LocationScreen({super.key, required this.deviceId});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final GeoLocatorService _geoLocatorService = sl();
  late final SendLocationCubit _sendLocationCubit;

  @override
  void initState() {
    super.initState();
    _sendLocationCubit = context.read<SendLocationCubit>();
  }

  Future<void> _sendDeviceLocation() async {
    Position determinePosition = await _geoLocatorService.determinePosition();

    DeviceLocationInputEntity deviceLocationInputEntity =
        DeviceLocationInputEntity(
            deviceId: widget.deviceId,
            lat: determinePosition.latitude,
            lon: determinePosition.longitude);

    _sendLocationCubit.sendDeviceLocation(deviceLocationInputEntity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SendLocationCubit, SendLocationState>(
        builder: (context, state) {
          if (state is SendLocationLoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is SendLocationSuccessState) {
            DeviceLocationOutputEntity deviceLocationOutputEntity =
                state.deviceLocationOutputEntity;
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                child: Column(
                  children: [
                    Text(deviceLocationOutputEntity.country),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(deviceLocationOutputEntity.city),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(deviceLocationOutputEntity.district),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is SendLocationErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Hata'),
                    content: Text(state.errorMessage!),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Tamam'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            });
          }

          return Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _sendDeviceLocation,
                    child: const Text('Send Device Location'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
