import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_analyzer_app/cubit/create_user_cubit.dart';
import 'package:geo_analyzer_app/cubit/create_user_state.dart';
import 'package:geo_analyzer_app/data/device_info_model.dart';
import 'package:geo_analyzer_app/data/input/user_info_input_entity.dart';
import 'package:geo_analyzer_app/injection_container.dart';
import 'package:geo_analyzer_app/service/user_service.dart';
import 'package:geo_analyzer_app/util/device_state_util.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserService userService = sl();
  final DeviceStateUtil deviceStateUtil = sl();
  final TextEditingController _controller = TextEditingController();

  Future<void> _saveUserAndDeviceInfo() async {
    DeviceInfoModel deviceInfoModel = await deviceStateUtil.getDeviceInfo();
    UserInfoInputEntity userInfoInputEntity = UserInfoInputEntity(
        deviceImei: deviceInfoModel.deviceImei,
        deviceName: deviceInfoModel.deviceModel,
        username: _controller.text);

    userService.saveUserAndDeviceInfo(userInfoInputEntity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateUserCubit, CreateUserState>(
      builder: (context, state) {
        if (state is CreateUserLoadingState) {
          return const CircularProgressIndicator();
        }

        if (state is CreateUserSuccessState) {
          // yeni bir sayfaya geçş yap
        }

        if (state is Error) {
          // ekrana hata mesajı göster
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter info',
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
    );
  }
}
