import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class HomeState extends Equatable {
  final HomeStatus status;
  final XFile? file;
  final String textExtracted;
  const HomeState({
    this.status = const HomeInitial(),
    this.file,
    this.textExtracted = '',
  });
  HomeState copyWith({HomeStatus? status, XFile? file, String? textExtracted}) {
    return HomeState(
      status: status ?? this.status,
      file: file ?? this.file,
      textExtracted: textExtracted ?? this.textExtracted,
    );
  }

  @override
  List<Object?> get props => [status, file, textExtracted];
}

abstract class HomeStatus extends Equatable {
  const HomeStatus();
}

class HomeInitial extends HomeStatus {
  const HomeInitial();
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeStatus {
  const HomeLoading();
  @override
  List<Object?> get props => [];
}

class HomeError extends HomeStatus {
  final String error;
  const HomeError(this.error);
  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeStatus {
  const HomeSuccess();
  @override
  List<Object?> get props => [];
}
