import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textract/features/home/data/repository/repo.dart';
import 'package:textract/features/home/logic/state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;
  HomeCubit(this._repository) : super(const HomeState());

  Future<void> pickImage(ImageSource source) async {
    emit(state.copyWith(status: const HomeLoading()));
    final pickedImage = await _repository.pickImage(source);
    pickedImage.fold(
      (l) => emit(state.copyWith(status: HomeError(l))),
      (r) => emit(state.copyWith(file: r)),
    );
  }

  Future<void> extractText() async {
    //emit(HomeState(status: const HomeLoading()));
    final File image = File(state.file!.path);
    final text = await _repository.extractText(image);
    text.fold(
      (l) => emit(state.copyWith(status: HomeError(l))),
      (r) => emit(state.copyWith(textExtracted: r, status: HomeSuccess())),
    );
  }

  void copyText() {
    Clipboard.setData(ClipboardData(text: state.textExtracted));
    Fluttertoast.showToast(
      msg: 'Text copied',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
