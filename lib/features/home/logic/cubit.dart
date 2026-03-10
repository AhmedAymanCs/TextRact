import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textract/features/home/data/repository/repo.dart';
import 'package:textract/features/home/logic/state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;
  HomeCubit(this._repository) : super(const HomeState());

  Future<void> pickImage(ImageSource source) async {
    emit(HomeState(status: const HomeLoading()));
    final pickedImage = await _repository.pickImage(source);
    pickedImage.fold(
      (l) => emit(HomeState(status: HomeError(l))),
      (r) => emit(HomeState(status: HomeSuccess(), file: r)),
    );
  }

  Future<void> extractText(File file) async {
    emit(HomeState(status: const HomeLoading()));
    final text = await _repository.extractText(file);
    text.fold(
      (l) => emit(HomeState(status: HomeError(l))),
      (r) => emit(HomeState(status: HomeSuccess(), textExtracted: r)),
    );
  }
}
