import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_grid_view.dart';
import 'package:flowery/features/best_seller/presentation/view_model/cubit/best_seller_view_model.dart';
import 'package:flowery/features/best_seller/presentation/view_model/events/best_seller_events.dart';
import 'package:flowery/features/best_seller/presentation/view_model/states/best_seller_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  late TextTheme textTheme;
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.h,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text(localizations.best_seller),
              Text(
                localizations.best_seller_title,
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.grayColor,
                ),
              ),
            ],
          ),
          titleSpacing: 0.0,
        ),
        body: BlocProvider<BestSellerViewModel>(
          create: (context) =>
              getIt.get<BestSellerViewModel>()
                ..doEvent(GetBestSellerProductsEvent()),
          child: BlocBuilder<BestSellerViewModel, BestSellerStates>(
            builder: (context, state) {
              if (state is BestSellerLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
              if (state is BestSellerSuccessState) {
                final products = state.products;

                if (products.isNotEmpty) {
                  return CustomGridView(
                    productsLength: products.length,
                    products: products,
                  );
                } else {
                  return Center(child: Text(localizations.no_products));
                }
              }
              if (state is BestSellerErrorState) {
                return Center(child: Text(localizations.an_error_occurred));
              }
              return CustomGridView(productsLength: 0, products: []);
            },
          ),
        ),
      ),
    );
  }
}
