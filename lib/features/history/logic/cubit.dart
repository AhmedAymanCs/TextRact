import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textract/features/history/data/repository/repo.dart';
import 'package:textract/features/history/logic/state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _repository;
  HistoryCubit(this._repository) : super(const HistoryState());

  Future<void> getTextFromDatabase() async {
    emit(state.copyWith(status: HistoryStatus.loading));
    final response = await _repository.getTextFromDatabase();
    response.fold(
      (l) => emit(state.copyWith(status: HistoryStatus.error)),
      (r) => emit(state.copyWith(status: HistoryStatus.success, texts: r)),
    );
  }
}
