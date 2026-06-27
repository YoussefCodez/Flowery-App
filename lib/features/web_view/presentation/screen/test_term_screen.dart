import 'package:flowery/config/routing/app_routes.dart';
import 'package:flutter/material.dart';

class TestTermScreen extends StatelessWidget {
  const TestTermScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.termsAndConditions),
              child: const Text('Terms & Conditions'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.aboutUs),
              child: const Text('About Us'),
            ),
          ],
        ),
      ),
    );
  }
}
