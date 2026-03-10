import 'package:equatable/equatable.dart';
import 'package:textract/core/models/text_form_model.dart';

enum HistoryStatus { initial, loading, success, error }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final List<TextFormModel> texts;
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.texts = const [],
  });
  HistoryState copyWith({HistoryStatus? status, List<TextFormModel>? texts}) {
    return HistoryState(
      status: status ?? this.status,
      texts: texts ?? this.texts,
    );
  }

  @override
  List<Object?> get props => [status, texts];
}
