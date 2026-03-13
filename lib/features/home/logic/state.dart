import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class HomeState extends Equatable {
  final HomeStatus status;
  final XFile? file;
  final String textExtracted;
  final String source;
  const HomeState({
    this.status = const HomeInitial(),
    this.file,
    this.textExtracted = '',
    this.source = '',
  });
  HomeState copyWith({
    HomeStatus? status,
    XFile? file,
    String? textExtracted,
    String? source,
  }) {
    return HomeState(
      status: status ?? this.status,
      file: file ?? this.file,
      textExtracted: textExtracted ?? this.textExtracted,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props => [status, file, textExtracted, source];
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
  List<Object?> get props => [error];
}

class HomeSuccess extends HomeStatus {
  const HomeSuccess();
  @override
  List<Object?> get props => [];
}
