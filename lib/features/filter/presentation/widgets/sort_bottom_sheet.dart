import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/filter/presentation/view_model/cubit/filter_view_model.dart';
import 'package:flowery/features/filter/presentation/view_model/state/filter_base_state.dart';
import 'package:flowery/features/filter/presentation/widgets/sort_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SortOption { lowestPrice, highestPrice, newest, oldest, discount }

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  static Future<void> show({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SortBottomSheet(),
    );
  }

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late SortOption selected;
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilterViewModel>(
      create: (_) => getIt<FilterViewModel>(),
      child: Builder(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.grayColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      localizations.sort_by,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  BlocBuilder<FilterViewModel, FilterBaseState>(
                    builder: (context, state) {
                      selected =
                          state.selectedSortOption ?? SortOption.lowestPrice;
                      return Column(
                        children: [
                          sortTile(
                            title: localizations.lowest_price,
                            value: SortOption.lowestPrice,
                            selected: selected,
                            context: context,
                          ),

                          sortTile(
                            title: localizations.highest_price,
                            value: SortOption.highestPrice,
                            selected: selected,
                            context: context,
                          ),

                          sortTile(
                            title: localizations.new_products,
                            value: SortOption.newest,
                            selected: selected,
                            context: context,
                          ),

                          sortTile(
                            title: localizations.old_products,
                            value: SortOption.oldest,
                            selected: selected,
                            context: context,
                          ),

                          sortTile(
                            title: localizations.discount,
                            value: SortOption.discount,
                            selected: selected,
                            context: context,
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.tune),
                      label: Text(
                        localizations.filter,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
