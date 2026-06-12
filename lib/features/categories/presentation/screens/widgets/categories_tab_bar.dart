import 'package:flowery/core/const/app_strings.dart';
import 'package:flowery/core/widgets/custom_grid_view.dart';
import 'package:flowery/features/categories/domain/entities/category_entity.dart';
import 'package:flowery/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowery/features/categories/presentation/view_model/events/categories_event.dart';
import 'package:flowery/features/categories/presentation/view_model/states/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTabView extends StatefulWidget {
  final List<CategoryEntity> categories;
  final String? categoryId;
  const CategoriesTabView({
    super.key,
    required this.categories,
    this.categoryId = '',
  });

  @override
  State<CategoriesTabView> createState() => _CategoriesTabViewState();
}

class _CategoriesTabViewState extends State<CategoriesTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    final selectedIndex = widget.categoryId != null
        ? widget.categories.indexWhere(
            (category) => category.id == widget.categoryId,
          )
        : -1;

    _tabController = TabController(
      length: widget.categories.length + 1,
      vsync: this,
      initialIndex: selectedIndex >= 0 ? selectedIndex + 1 : 0,
    );

    context.read<CategoriesCubit>().doEvent(
      GetProductsByCategoryEvent(
        widget.categoryId?.isNotEmpty == true ? widget.categoryId : null,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          onTap: (index) {
            if (index == 0) {
              context.read<CategoriesCubit>().doEvent(
                GetProductsByCategoryEvent(),
              );
            } else {
              final selectedCategory = widget.categories[index - 1];
              context.read<CategoriesCubit>().doEvent(
                GetProductsByCategoryEvent(selectedCategory.id ?? ''),
              );
            }
          },
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
          indicatorColor: Theme.of(context).colorScheme.primary,
          dividerColor: Colors.transparent,
          tabs: [
            const Tab(text: AppStrings.allCategories),
            ...widget.categories.map((c) => Tab(text: c.name ?? '')),
          ],
        ),
        Expanded(
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            buildWhen: (prev, curr) => prev.productsState != curr.productsState,
            builder: (context, state) {
              return state.productsState.when(
                initial: () =>
                    const Center(child: Text(AppStrings.selectCategory)),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (products) {
                  if (products.isEmpty) {
                    return const Center(
                      child: Text(AppStrings.noProductsFound),
                    );
                  }
                  return CustomGridView(
                    productsLength: products.length,
                    products: products,
                  );
                },
                error: (e) => Center(child: Text(e.toString())),
              );
            },
          ),
        ),
      ],
    );
  }
}
