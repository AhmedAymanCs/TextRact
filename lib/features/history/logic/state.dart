import 'package:equatable/equatable.dart';
import 'package:textract/core/models/text_form_model.dart';

enum HistoryStatus { initial, loading, success, error, search }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final List<TextFormModel> texts;
  final List<TextFormModel> searchTexts;
  final String errorMessage;
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.texts = const [],
    this.searchTexts = const [],
    this.errorMessage = '',
  });
  HistoryState copyWith({
    HistoryStatus? status,
    List<TextFormModel>? texts,
    List<TextFormModel>? searchTexts,
    String? errorMessage,
  }) {
    return HistoryState(
      status: status ?? this.status,
      texts: texts ?? this.texts,
      searchTexts: searchTexts ?? this.searchTexts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, texts, searchTexts, errorMessage];
}
