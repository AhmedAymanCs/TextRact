import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textract/core/utils/typedef.dart';
import 'package:textract/features/home/data/data_source/data_source.dart';
import 'package:textract/features/home/data/models/text_form_model.dart';

abstract class HomeRepository {
  ServerResponse<XFile?> pickImage(ImageSource source);
  ServerResponse<String> extractText(File file);
  ServerResponse<Unit> saveTextInDatabase(TextFormModel text);
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _dataSource;
  HomeRepositoryImpl(this._dataSource);
  @override
  ServerResponse<String> extractText(File file) async {
    try {
      final String text = await _dataSource.extractText(
        InputImage.fromFile(file),
      );
      return Right(text);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<XFile?> pickImage(ImageSource source) async {
    try {
      final XFile? pickedImage = await _dataSource.pickImage(source);
      return Right(pickedImage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> saveTextInDatabase(TextFormModel text) async {
    try {
      await _dataSource.saveTextInDatabase(text);
      return Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
