enum ProfileStatus { initial, loading, success, error }

class ProfileState {
  final ProfileStatus status;
  const ProfileState({this.status = ProfileStatus.initial});
  ProfileState copyWith({ProfileStatus? status}) {
    return ProfileState(status: status ?? this.status);
  }
}
