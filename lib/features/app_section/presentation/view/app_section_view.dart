import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/app_section_cubit.dart';
import '../view_model/app_section_state.dart';
import '../widget/nav_bar_custom_widget.dart';

class AppSectionView extends StatelessWidget {
  const AppSectionView({super.key});

  static final List<Widget> _tabs = const [
    // HomeView(),
    // CategoriesView(),
    // CartView(),
    // ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppSectionCubit(),
      child: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          return PopScope(
            canPop: state.currentIndex == 0,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop) {
                context.read<AppSectionCubit>().goToHome();
              }
            },
            child: Scaffold(
              body: IndexedStack(index: state.currentIndex, children: _tabs),
              bottomNavigationBar: NavBarCustomWidget(
                currentIndex: state.currentIndex,
                onTap: (index) =>
                    context.read<AppSectionCubit>().changeTab(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
//bottomNavigationBar: NavBarCustomWidget(
//         currentIndex: 0, // ← أي tab يبقى selected (عادةً Home)
//         onTap: (index) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             AppRoutes.appSection,
//             (route) => false,
//           );
//         },
//       ),