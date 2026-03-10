import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textract/features/profile/data/repository/repo.dart';
import 'package:textract/features/profile/logic/state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;
  ProfileCubit(this._repository) : super(const ProfileState());

  Future<void> getUserData() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final response = await _repository.getUserData();
    response.fold(
      (l) => emit(state.copyWith(status: ProfileStatus.error)),
      (r) => emit(state.copyWith(user: r, status: ProfileStatus.success)),
    );
  }
}
