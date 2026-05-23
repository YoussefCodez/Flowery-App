import 'package:flowery/features/app_language_logout/presntation/widgets/language_tile.dart';
import 'package:flowery/features/app_language_logout/presntation/widgets/logout_button.dart';
import 'package:flutter/material.dart';

class DemoLogoutLanguagePage extends StatelessWidget {
  const DemoLogoutLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          LanguageTile(),
          LogoutButton(),
        ],
      ),
    );
  }
}
