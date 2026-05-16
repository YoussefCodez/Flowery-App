import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/const/app_strings.dart';
import 'package:flowery/features/categories/presentation/screens/widgets/categories_tab_bar.dart';
import 'package:flowery/features/categories/presentation/screens/widgets/filter_button.dart';
import 'package:flowery/features/categories/presentation/screens/widgets/search_field.dart';
import 'package:flowery/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowery/features/categories/presentation/view_model/events/categories_event.dart';
import 'package:flowery/features/categories/presentation/view_model/states/categories_state.dart';
import 'package:flowery/features/home/presentation/widget/navbar_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatelessWidget {
  final String? selectedCategoryId;
  const CategoriesScreen({super.key, this.selectedCategoryId = ""});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CategoriesCubit>()..doEvent(GetAllCategoriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Search and filter
              Padding(
                padding: REdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: SearchField(hintText: AppStrings.search),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    FilterButton(
                      onTap: () {}, //TODO: Implement filter functionality
                    ),
                  ],
                ),
              ),

              // Categories tab and products
              Expanded(
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    return state.categoriesState.when(
                      success: (categories) {
                        return CategoriesTabView(
                          categories: categories,
                          selectedCategoryId: selectedCategoryId,
                        );
                      },
                      loading: () {
                        return const Center(child: CircularProgressIndicator());
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
        bottomNavigationBar: NavBarCustomWidget(currentIndex: 1),
      ),
    );
  }
}
