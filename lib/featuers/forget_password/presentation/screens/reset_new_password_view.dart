import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/helpers/validators.dart';
import '../../../../config/l10n/translations/app_localizations.dart';
import '../../../../config/routing/app_routes.dart';
import '../../../../config/routing/routing_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/model/reqest_models/reset_password_request.dart';
import '../view_model/cubit/forget_password_view_model.dart';
import '../view_model/event/forget_password_event.dart';
import '../view_model/state/forget_password_status.dart';
import '../widget/custom_app_bar.dart';

// BlocProvider is NOT created here. RouteGenerator injects the shared
// ForgetPasswordViewModel via BlocProvider.value before building this widget.
class ResetNewPasswordView extends StatefulWidget {
  const ResetNewPasswordView({super.key});

  @override
  State<ResetNewPasswordView> createState() => _ResetNewPasswordViewState();
}

class _ResetNewPasswordViewState extends State<ResetNewPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
      listenWhen: (prev, curr) =>
          prev.resetPasswordState != curr.resetPasswordState,

      listener: (context, state) {
        state.resetPasswordState.when(
          success: (_) => context.pushNamedAndRemoveUntil(
            AppRoutes.login,
            predicate: (route) => false,
          ),
          loading: () {},
          initial: () {},
          error: (e) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString()))),
        );
      },

      builder: (context, state) {
        final isLoading = state.resetPasswordState.state == StateType.loading;

        return Scaffold(
          appBar: customAppBar(context),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 38.h),

                    Text(
                      l10n.reset_password,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      l10n.password_must_not_be_empty,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.grayColor,
                      ),
                    ),

                    SizedBox(height: 30.h),

                    CustomTextFormField(
                      hintText: l10n.enter_your_password,
                      labelText: l10n.new_password,
                      controller: _passwordController,
                      validator: (value) =>
                          Validations.validatePassword(context, value),
                    ),

                    SizedBox(height: 22.h),

                    CustomTextFormField(
                      hintText: l10n.confirm_password,
                      labelText: l10n.confirm_password,
                      controller: _confirmController,
                      validator: (value) => Validations.validateConfirmPassword(
                        context,
                        value,
                        _passwordController.text,
                      ),
                    ),

                    SizedBox(height: 48.h),

                    CustomButton(
                      backgroundColor: AppColors.primaryColor,

                      foregroundColor: AppColors.whiteColor,

                      textColor: AppColors.whiteColor,

                      borderColor: AppColors.primaryColor,

                      text: l10n.confirm,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<ForgetPasswordViewModel>()
                                    .doIntent(
                                      event: ResetPasswordEvent(
                                        request: ResetPasswordRequest(
                                          email: state.email ?? '',
                                          password: _passwordController.text
                                              .trim(),
                                        ),
                                      ),
                                    );
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
