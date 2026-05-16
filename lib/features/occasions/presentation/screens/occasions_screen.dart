import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_grid_view.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flowery/features/occasions/presentation/view_model/cubit/occasion_view_model.dart';
import 'package:flowery/features/occasions/presentation/view_model/events/occasions_events.dart';
import 'package:flowery/features/occasions/presentation/view_model/states/occasions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OccasionsScreen extends StatefulWidget {
  final String? selectedOccasionId;
  const OccasionsScreen({super.key, this.selectedOccasionId = ""});

  @override
  State<OccasionsScreen> createState() => _OccasionsScreenState();
}

class _OccasionsScreenState extends State<OccasionsScreen> {
  late TextTheme textTheme;
  late AppLocalizations localizations;
  bool loadFirstOccasion = true;
  bool loadNavigatedOccasion = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    localizations = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OccasionViewModel>(
      create: (context) {
        return getIt.get<OccasionViewModel>()
          ..doEvent(GetOccasionsEvent(), incomingIndex: -1);
      },

      child: ScreenUtilInit(
        designSize: Size(375.sp, 812.sp),
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
                Text(localizations.occasion),
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

          body: BlocBuilder<OccasionViewModel, OccasionsStates>(
            builder: (context, state) {
              if (state is OccasionsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
              return Column(
                children: [
                  // Occasions
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 40.h,

                      child: BlocBuilder<OccasionViewModel, OccasionsStates>(
                        builder: (context, state) {
                          if (state is OccasionsSuccessState) {
                            final List<String> occasionsNames =
                                state.names ?? [];
                            final List<String> occasionsIds = state.ids ?? [];

                            // default is -1
                            int incomingIndex = occasionsIds.indexOf(
                              widget.selectedOccasionId ?? "",
                            );

                            // for view all and also if the selected occasion doesn't locate
                            if (occasionsIds.isNotEmpty &&
                                loadFirstOccasion &&
                                incomingIndex == -1) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.read<OccasionViewModel>().doEvent(
                                  GetProductsOfSpecificOccasion(),
                                  occasionId: occasionsIds[0],
                                  index: 0,
                                );
                                loadFirstOccasion = false;
                              });
                            }

                            // Load products automatically for passed occasion id
                            if (incomingIndex != -1 && loadNavigatedOccasion) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.read<OccasionViewModel>().doEvent(
                                  GetProductsOfSpecificOccasion(),
                                  occasionId: widget.selectedOccasionId,
                                  index: incomingIndex,
                                );
                              });
                              loadNavigatedOccasion = false;
                            }

                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: occasionsNames.length,
                              separatorBuilder: (_, index) =>
                                  SizedBox(width: 16.w),
                              itemBuilder: (context, index) {
                                final isSelected = state.selectedIndex == index;

                                return InkWell(
                                  onTap: () {
                                    context.read<OccasionViewModel>().doEvent(
                                      GetProductsOfSpecificOccasion(),
                                      occasionId: occasionsIds[index],
                                      index: index,
                                      incomingIndex: -1,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        occasionsNames[index],
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: isSelected
                                              ? AppColors.primaryColor
                                              : AppColors.grayColor,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        width: 63.sp,
                                        height: 3.h,
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : AppColors.grayColor,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          if (state is OccasionsFailedState) {
                            return CircularProgressIndicator(
                              color: AppColors.redColor,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Products
                  Expanded(
                    child: BlocBuilder<OccasionViewModel, OccasionsStates>(
                      builder: (BuildContext context, state) {
                        if (state is OccasionsFailedState) {
                          return CircularProgressIndicator(
                            color: AppColors.redColor,
                          );
                        }
                        if (state is OccasionsSuccessState) {
                          final List<ProductEntity> products =
                              state.products ?? [];
                          if (products.isNotEmpty) {
                            return CustomGridView(
                              products: products,
                              productsLength: products.length,
                            );
                          } else {
                            return Center(
                              child: Text(
                                localizations.no_products,
                                style: textTheme.bodyMedium,
                              ),
                            );
                          }
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
