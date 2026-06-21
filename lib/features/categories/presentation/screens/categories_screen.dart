import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/const/app_strings.dart';
import 'package:flowery/features/categories/presentation/screens/widgets/categories_tab_bar.dart';
import 'package:flowery/features/categories/presentation/screens/widgets/filter_button.dart';
import 'package:flowery/features/categories/presentation/screens/widgets/search_field.dart';
import 'package:flowery/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowery/features/categories/presentation/view_model/events/categories_event.dart';
import 'package:flowery/features/categories/presentation/view_model/states/categories_state.dart';
import 'package:flowery/features/filter/presentation/widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatefulWidget {
  final bool showBackButton;
  final String? categoryId;
  const CategoriesScreen({
    super.key,
    required this.showBackButton,
    this.categoryId = "",
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CategoriesCubit>()..doEvent(GetAllCategoriesEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: REdgeInsets.all(16),
                    child: Row(
                      children: [
                        widget.showBackButton
                            ? InkWell(
                                onTap: () => context.pop(),
                                child: Icon(Icons.arrow_back_ios_new),
                              )
                            : SizedBox.shrink(),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: SizedBox(
                            height: 48.h,
                            child: SearchField(hintText: localizations.search),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        FilterButton(
                          onTap: () {
                            // call the bottom sheet
                            SortBottomSheet.show(
                              context: context,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        return state.categoriesState.when(
                          success: (categories) {
                            return CategoriesTabView(
                              categories: categories,
                              categoryId: widget.categoryId,
                            );
                          },
                          loading: () {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          error: (error) {
                            return Center(child: Text(error.toString()));
                          },
                          initial: () {
                            return const Center(
                              child: Text(AppStrings.initialCategoryState),
                            );
                          },
                        );
                      },
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
