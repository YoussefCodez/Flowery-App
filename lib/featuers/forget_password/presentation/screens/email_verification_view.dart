import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/l10n/translations/app_localizations.dart';
import '../../../../config/routing/app_routes.dart';
import '../../../../config/routing/routing_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../view_model/cubit/forget_password_view_model.dart';
import '../view_model/state/forget_password_status.dart';
import '../widget/custom_app_bar.dart';
import '../widget/otp_section.dart';


class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
      listenWhen: (prev, curr) =>
      prev.verifyEmailState != curr.verifyEmailState,
      listener: (context, state) {
        state.verifyEmailState.when(
          success: (_) => context.pushNamed(
            AppRoutes.resetPassword,
            arguments: context.read<ForgetPasswordViewModel>(),
          ),
          loading: () {},
          initial: () {},
          error: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          },
        );
      },
      child: Scaffold(
        appBar: customAppBar(context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 38.h),

              Text(
                l10n.email_verification,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.h),

              Text(
                l10n.please_enter_your_code_that_send_to_your_email_address,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.grayColor,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40.h),

              const OtpSection(),
            ],
          ),
        ),
      ),
    );
  }
}
