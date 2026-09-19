import 'package:flowery/config/general_cubit/constants.dart';
import 'package:flutter/material.dart';

class SignUpButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(AppConstants.signUpScreenName),
      ),
    );
  }
}
