import 'package:flowery/features/categories/presentation/screens/categories_screen.dart';
import 'package:flowery/features/home/presentation/screens/home_view.dart';
import 'package:flowery/features/home/presentation/widget/navbar_custom_widget.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final screens = [
    const HomeView(),
    const CategoriesScreen(showBackButton: false,),
    // const CartScreen(),
    // const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavBarCustomWidget(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}