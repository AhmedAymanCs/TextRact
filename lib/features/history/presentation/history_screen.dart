import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textract/core/constants/string_manager.dart';
import 'package:textract/core/di/service_locator.dart';
import 'package:textract/core/models/text_form_model.dart';
import 'package:textract/core/widgets/cutom_form_field.dart';
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
        appBar: AppBar(title: Text(StringManager.history)),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            late List<TextFormModel> texts;
            if (state.status == HistoryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.texts.isEmpty) {
              return const Center(child: Text(StringManager.emptyHistory));
            }
            if (state.status == HistoryStatus.search) {
              texts = state.searchTexts;
            } else {
              texts = state.texts;
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomFormField(
                    hint: StringManager.search,
                    preicon: Icons.search_rounded,
                    onChanged: (value) {
                      context.read<HistoryCubit>().searchText(value!);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(15),
                    itemCount: texts.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return HistoryItem(
                        item: texts[index],
                        onDelete: () => context.read<HistoryCubit>().deleteText(
                          texts[index].id,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
