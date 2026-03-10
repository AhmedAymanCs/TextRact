import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textract/features/profile/logic/state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
}
