import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/search/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../view_model/search_cubit.dart';
import '../view_model/search_state.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchViewModel, SearchState>(
      builder: (context, state) {
        return state.searchState.when(
          initial: () => Center(
            child: Text(
              localizations.search_for_any_product_you_want,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          error: (exception) => Center(
            child: Text(
              exception.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
          success: (products) => products.length == 0
              ? Center(
                  child: Text(
                    'No Products Found',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.only(top: 15.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product: product);
                  },
                ),
        );
      },
    );
  }
}
