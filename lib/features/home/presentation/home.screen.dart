import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: IconButton(
          onPressed: () {
            context.pushNamed(AppRoutes.login);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(child: Text("Home")),
    );
  }
}
