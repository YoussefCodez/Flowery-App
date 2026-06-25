import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/featuers/my_order/presentation/view_model/my_order_bloc.dart';
import 'package:flowery/featuers/my_order/presentation/view_model/my_order_event.dart';
import 'package:flowery/featuers/my_order/presentation/view_model/my_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_product_card.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyOrderBloc>()..doEvent(GetMyOrdersData()),
      child: Scaffold(
        appBar: customAppBar(context),
        body: BlocBuilder<MyOrderBloc, MyOrderState>(
          builder: (context, state) {

            return DynamicTabBarWidget(
              dividerColor: AppColors.hintGrayColor,
              dynamicTabs: [
                TabData(
                  index: 1,
                  title: const Tab(child: Text('Active')),
                  content: state.activeOrdersState.when(
                    success: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => CustomProductCard2(
                        orderItem: data[index],
                        isActive: true,
                      ),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e) => Center(child: Text(e.toString())),
                    initial: ()=> const SizedBox(),
                  ),
                ),
                TabData(
                  index: 2,
                  title: const Tab(child: Text('Completed')),
                  content: state.completedOrdersState.when(
                    initial: () => const SizedBox(),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    success: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => CustomProductCard2(
                        orderItem: data[index],
                        isActive: false,
                      ),
                    ),
                    error: (e) => Center(child: Text(e.toString())),
                  ),
                ),
              ],
              isScrollable: false,
              showBackIcon: false,
              showNextIcon: false,
              onTabChanged: (index) {},
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Color(0xFFD63384), width: 4.0),
                insets: EdgeInsets.zero,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: const Color(0xFFD63384),
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              onTabControllerUpdated: (TabController p1) {},
            );
          },
        ),
      ),
    );
  }
}
