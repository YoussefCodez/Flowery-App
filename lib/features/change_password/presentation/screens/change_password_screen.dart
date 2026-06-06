import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AppLocalizations localizations;
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(localizations.reset_password),
        titleSpacing: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              MainTextField(
                hintText: localizations.current_password,
                labelText: localizations.current_password,
                controller: currentPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.password_is_required;
                  }
                  // TODO: check if the old password is wrong
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              MainTextField(
                hintText: localizations.new_password,
                labelText: localizations.new_password,
                controller: newPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.password_is_required;
                  }
                  if (!AppRegExp.isPasswordValid(value)) {
                    return localizations.password_is_not_valid;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              MainTextField(
                hintText: localizations.confirm_password,
                labelText: localizations.confirm_password,
                controller: confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.confirm_password_is_required;
                  }
                  if (value != newPasswordController.text) {
                    return localizations
                        .password_and_confirm_password_must_be_same;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                child: Text(localizations.update),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: CHANGE PASSWORD EVENT
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
