import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:textract/core/constants/app_constants.dart';
import 'package:textract/core/constants/color_manager.dart';
import 'package:textract/core/constants/font_manager.dart';
import 'package:textract/core/models/text_form_model.dart';

class HistoryItem extends StatelessWidget {
  final TextFormModel item;
  final VoidCallback? onDelete;
  const HistoryItem({super.key, required this.item, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final String formatted = DateFormat(
      AppConstants.dateTimeFormat,
    ).format(item.createdAt);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.photo_library_rounded, size: 16),
              const SizedBox(width: 6),
              Text(
                item.source,
                style: const TextStyle(fontWeight: FontWeightManager.bold),
              ),
              const Spacer(),
              Text(
                formatted,
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorManager.gray500,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            children: [
              Text(
                item.text,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete_outline, color: ColorManager.error),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
