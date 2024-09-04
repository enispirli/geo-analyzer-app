import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_analyzer_app/cubit/send_location_cubit.dart';
import 'package:geo_analyzer_app/cubit/send_location_state.dart';
import 'package:geo_analyzer_app/data/input/device_location_input_entity.dart';
import 'package:geo_analyzer_app/injection_container.dart';
import 'package:geo_analyzer_app/service/location_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final LocationService _locationService = sl();

  Future<void> _sendDeviceLocation() async {
// get device locations.

    DeviceLocationInputEntity deviceLocationInputEntity =
        const DeviceLocationInputEntity(
            deviceId: 1, lat: 41.0540289542, lon: 28.8636917583);

    _locationService.sendDeviceLocation(deviceLocationInputEntity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendLocationCubit, SendLocationState>(
      builder: (context, state) {
        if (state is SendLocationLoadingState) {
          return const CircularProgressIndicator();
        }

        if (state is SendLocationSuccessState) {
          // yeni bir sayfaya geçş yap
        }

        if (state is SendLocationErrorState) {
          // ekrana hata mesajı göster
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
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
    );
  }
}
