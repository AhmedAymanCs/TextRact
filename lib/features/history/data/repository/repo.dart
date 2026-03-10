import 'package:dartz/dartz.dart';
import 'package:textract/core/models/text_form_model.dart';
import 'package:textract/core/utils/typedef.dart';
import 'package:textract/features/history/data/data_source/data_source.dart';

abstract class HistoryRepository {
  ServerResponse<List<TextFormModel>> getTextFromDatabase();
}

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource _dataSource;
  HistoryRepositoryImpl(this._dataSource);
  @override
  ServerResponse<List<TextFormModel>> getTextFromDatabase() async {
    try {
      final response = await _dataSource.getTextFromDatabase();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
