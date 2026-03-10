import 'package:equatable/equatable.dart';
import 'package:textract/core/models/user_model.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel user;
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user = const UserModel(),
  });
  ProfileState copyWith({ProfileStatus? status, UserModel? user}) {
    return ProfileState(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, user];
}
