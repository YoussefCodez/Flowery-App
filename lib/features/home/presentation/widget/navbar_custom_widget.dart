import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../config/l10n/translations/app_localizations.dart';
import '../../../../config/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';

class NavBarCustomWidget extends StatelessWidget {
  final int currentIndex;

  const NavBarCustomWidget({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.home);
            break;
          case 1:
            context.pushNamed(AppRoutes.categories);
            break;
          case 2:
           // Navigator.pushNamed(context, AppRoutes.cartView);
            break;
          case 3:
           // Navigator.pushNamed(context, AppRoutes.profileView);
            break;
        }
      },
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: l10n.home,
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          activeIcon: Icon(Icons.category),
          label: l10n.categories,
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: l10n.cart,
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: l10n.profile,
        ),
      ],
    );
  }
}