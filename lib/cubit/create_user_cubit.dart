import 'package:geo_analyzer_app/cubit/create_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_analyzer_app/data/input/user_info_input_entity.dart';
import 'package:geo_analyzer_app/data/output/user_info_output_entity.dart';
import 'package:geo_analyzer_app/service/user_service.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  final UserService _userService;

  CreateUserCubit(this._userService) : super(const CreateUserInitialState());

  Future<void> saveUserAndDeviceInfo(UserInfoInputEntity input) async {
    emit(const CreateUserLoadingState());

    try {
      UserInfoOutputEntity userInfoOutputEntity =
          await _userService.saveUserAndDeviceInfo(input);

      emit(CreateUserSuccessState(userInfoOutputEntity));
    } on Exception catch (e) {
      emit(CreateUserErrorState(e.toString()));
    }
  }
}
