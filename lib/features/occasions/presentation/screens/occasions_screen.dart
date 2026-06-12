import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_grid_view.dart';
import 'package:flowery/features/occasions/presentation/view_model/cubit/occasion_view_model.dart';
import 'package:flowery/features/occasions/presentation/view_model/events/occasions_events.dart';
import 'package:flowery/features/occasions/presentation/view_model/states/occasions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OccasionsScreen extends StatefulWidget {
  final String? occasionId;
  const OccasionsScreen({
    super.key,
    required this.occasionId,
    String? selectedOccasionId,
  });

  @override
  State<OccasionsScreen> createState() => _OccasionsScreenState();
}

class _OccasionsScreenState extends State<OccasionsScreen>
    with TickerProviderStateMixin {
  late TextTheme textTheme;
  late AppLocalizations localizations;

  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    localizations = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OccasionViewModel>(
      create: (context) => getIt.get<OccasionViewModel>()
        ..doEvent(
          GetOccasionsEvent(),
          occasionId: widget.occasionId?.isNotEmpty == true
              ? widget.occasionId
              : null,
        ),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: BlocConsumer<OccasionViewModel, OccasionsState>(
              listenWhen: (previous, current) =>
                  previous.names.length != current.names.length,
              listener: (context, state) {
                _tabController?.dispose();
                _tabController = TabController(
                  length: state.names.length,
                  vsync: this,
                );
                if (widget.occasionId?.isNotEmpty == true) {
                  final selectedIndex = state.ids.indexOf(widget.occasionId!);

                  if (selectedIndex >= 0 &&
                      selectedIndex < _tabController!.length) {
                    _tabController!.index = selectedIndex;
                  }
                }

                // Listen to manual tab clicks
                _tabController?.addListener(() {
                  if (_tabController!.indexIsChanging) {
                    context.read<OccasionViewModel>().doEvent(
                      GetProductsOfSpecificOccasion(),
                      occasionId: state.ids[_tabController!.index],
                    );
                  }
                });
              },
              builder: (BuildContext context, OccasionsState state) {
                // initializing the tab controller and getting the first occasion products
                if (_tabController == null ||
                    _tabController!.length != state.names.length) {
                  _tabController?.dispose();
                  _tabController = TabController(
                    length: state.names.length,
                    vsync: this,
                  );
                }

                return TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: state.names.map((name) {
                    return Tab(text: name);
                  }).toList(),
                );
              },
            ),
          ),
        ),
        body: BlocBuilder<OccasionViewModel, OccasionsState>(
          builder: (context, state) {
            if (state.isLoadingOccasions) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isLoadingProducts) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
              return Center(child: Text(localizations.an_error_occurred));
            }
            if (state.products.isEmpty) {
              return Center(child: Text(localizations.no_products));
            }
            return CustomGridView(
              productsLength: state.products.length,
              products: state.products,
            );
          },
        ),
      ),
    );
  }
}
