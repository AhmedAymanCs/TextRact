import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textract/core/models/user_model.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel user;
  final XFile? file;
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user = const UserModel(),
    this.file,
  });
  ProfileState copyWith({ProfileStatus? status, UserModel? user, XFile? file}) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [status, user, file];
}
