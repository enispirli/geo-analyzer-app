import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_analyzer_app/cubit/create_user_cubit.dart';
import 'package:geo_analyzer_app/cubit/create_user_state.dart';
import 'package:geo_analyzer_app/data/device_info_model.dart';
import 'package:geo_analyzer_app/data/input/user_info_input_entity.dart';
import 'package:geo_analyzer_app/injection_container.dart';
import 'package:geo_analyzer_app/pages/location.dart';
import 'package:geo_analyzer_app/util/device_state_util.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final CreateUserCubit createUserCubit;
  final DeviceStateUtil deviceStateUtil = sl();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    createUserCubit = context.read<CreateUserCubit>();
  }

  Future<void> _saveUserAndDeviceInfo() async {
    DeviceInfoModel deviceInfoModel = await deviceStateUtil.getDeviceInfo();
    UserInfoInputEntity userInfoInputEntity = UserInfoInputEntity(
        deviceImei: deviceInfoModel.deviceImei,
        deviceName: deviceInfoModel.deviceModel,
        username: _controller.text);

    createUserCubit.saveUserAndDeviceInfo(userInfoInputEntity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateUserCubit, CreateUserState>(
      builder: (context, state) {
        if (state is CreateUserLoadingState) {
          return const CircularProgressIndicator();
        }

        if (state is CreateUserErrorState) {
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
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter username ',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveUserAndDeviceInfo,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is CreateUserSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LocationScreen(deviceId: state.userInfoOutputEntity.deviceId),
            ),
          );
        }
      },
    );
  }
}
