import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textract/core/models/text_form_model.dart';
import 'package:textract/features/home/data/repository/repo.dart';
import 'package:textract/features/home/logic/state.dart';
import 'package:uuid/v4.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;
  HomeCubit(this._repository) : super(const HomeState());

  Future<void> pickImage(ImageSource source) async {
    emit(state.copyWith(status: const HomeLoading()));
    final pickedImage = await _repository.pickImage(source);
    pickedImage.fold(
      (error) => emit(state.copyWith(status: HomeError(error))),
      (file) => emit(
        state.copyWith(
          file: file,
          source: source == ImageSource.camera ? 'Camera' : 'Gallery',
        ),
      ),
    );
  }

  Future<void> extractText() async {
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

  void saveTextInDatabase() {
    _repository.saveTextInDatabase(
      TextFormModel(
        id: UuidV4().generate(),
        text: state.textExtracted,
        source: state.source == '' ? 'Not Found' : state.source,
        createdAt: DateTime.now(),
      ),
    );
  }
}
