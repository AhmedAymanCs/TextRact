import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textract/core/di/service_locator.dart';
import 'package:textract/features/history/data/repository/repo.dart';
import 'package:textract/features/history/logic/cubit.dart';
import 'package:textract/features/history/logic/state.dart';
import 'package:textract/features/history/presentation/shared_widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HistoryCubit(getIt<HistoryRepository>())..getTextFromDatabase(),
      child: Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state.status == HistoryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.texts.isEmpty) {
              return const Center(child: Text('No history yet'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.texts.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = state.texts[index];
                return HistoryItem(item: item);
              },
            );
          },
        ),
      ),
    );
  }
}
