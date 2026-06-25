import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/filter/presentation/view_model/cubit/filter_view_model.dart';
import 'package:flowery/features/filter/presentation/view_model/events/filter_events.dart';
import 'package:flowery/features/filter/presentation/widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget sortTile({
  required String title,
  required SortOption value,
  required SortOption selected,
  required BuildContext context,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.grayColor),
      borderRadius: BorderRadius.circular(12),
    ),
    child: RadioMenuButton<SortOption>(
      value: value,
      groupValue: selected,
      onChanged: (value) {
        context.read<FilterViewModel>().doEvent(
          UpdateSortOptionEvent(sortOption: value!),
        );
      },
      child: Text(title),
    ),
  );
}
