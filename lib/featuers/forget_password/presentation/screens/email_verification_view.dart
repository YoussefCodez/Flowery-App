import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/l10n/translations/app_localizations.dart';
import '../../../../config/routing/app_routes.dart';
import '../../../../config/routing/routing_extensions.dart';
import '../../../../core/theme/app_colors.dart';

import '../../data/model/reqest_models/forget_password_request.dart';
import '../view_model/cubit/forget_password_view_model.dart';
import '../view_model/event/forget_password_event.dart';
import '../view_model/state/forget_password_status.dart';
import '../widget/custom_app_bar.dart';


class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  String _formatTimer(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
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
          error: (e) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          ),
        );
      },

      buildWhen: (prev, curr) =>
          prev.verifyEmailState != curr.verifyEmailState ||
          prev.isResendEnabled != curr.isResendEnabled ||
          prev.timerValue != curr.timerValue ||
          prev.hasError != curr.hasError ||
          prev.otpValue != curr.otpValue ||
          prev.otpResetKey != curr.otpResetKey,

      builder: (context, state) {
        final isLoading = state.verifyEmailState.state == StateType.loading;
        final cubit = context.read<ForgetPasswordViewModel>();

        return Scaffold(
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

                Stack(
                  alignment: Alignment.center,
                  children: [
                    IgnorePointer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (i) {
                          final char = i < state.otpValue.length
                              ? state.otpValue[i]
                              : '';
                          final isCurrent =
                              i == state.otpValue.length && !isLoading;

                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            width: 40.w,
                            height: 56.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: state.hasError
                                    ? Colors.red
                                    : isCurrent
                                        ? AppColors.primaryColor
                                        : AppColors.hintGrayColor,
                                width: isCurrent || state.hasError ? 2 : 1.5,
                              ),
                            ),
                            child: Text(
                              char,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),


                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: Opacity(
                        opacity: 0.0,
                        child: TextField(
                          key: ValueKey(state.otpResetKey),
                          autofocus: true,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          enabled: !isLoading,
                          onChanged: (val) => cubit.doIntent(
                            event: UpdateOtpEvent(otp: val),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                if (state.hasError) ...[
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 16),
                      SizedBox(width: 6.w),
                      Text(
                        l10n.invalid_code,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ],
                  ),
                ],


                SizedBox(
                  height: 28,
                  child: isLoading
                      ? const CircularProgressIndicator(strokeWidth: 2.5)
                      : null,
                ),

                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.didnt_receive_code,
                      style: const TextStyle(
                          color: Colors.black54, fontSize: 14),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: state.isResendEnabled
                          ? () => cubit.doIntent(
                                event: SendEmailEvent(
                                  request: ForgetPasswordRequest(
                                    email: state.email ?? '',
                                  ),
                                ),
                              )
                          : null,
                      child: Text(
                        l10n.resend,
                        style: TextStyle(
                          color: state.isResendEnabled
                              ? Colors.red
                              : Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: state.isResendEnabled
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                if (!state.isResendEnabled) ...[
                  SizedBox(height: 8.h),
                  Text(
                    _formatTimer(state.timerValue),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.grayColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
