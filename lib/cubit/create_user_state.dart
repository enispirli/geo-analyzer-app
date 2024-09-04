import 'package:equatable/equatable.dart';
import 'package:geo_analyzer_app/data/output/user_info_output_entity.dart';

abstract class CreateUserState extends Equatable {
  const CreateUserState();

  @override
  List<Object?> get props => [];
}

class CreateUserInitialState extends CreateUserState {
  const CreateUserInitialState();
}

class CreateUserLoadingState extends CreateUserState {
  const CreateUserLoadingState();
}

class CreateUserSuccessState extends CreateUserState {
  final UserInfoOutputEntity userInfoOutputEntity;
  const CreateUserSuccessState(this.userInfoOutputEntity);
}

class CreateUserErrorState extends CreateUserState {
  final String? errorMessage;
  const CreateUserErrorState(this.errorMessage);
}

class CreateUserCancelState extends CreateUserState {
  const CreateUserCancelState();
}
