import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flowery/features/change_password/presentation/view_model/cubit/change_password_view_model.dart';
import 'package:flowery/features/change_password/presentation/view_model/events/change_password_events.dart';
import 'package:flowery/features/change_password/presentation/view_model/states/change_password_base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider<ChangePasswordViewModel>(
      create: (context) => getIt.get<ChangePasswordViewModel>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              title: Text(localizations.reset_password),
              titleSpacing: 0.0,
            ),
            body:
                BlocListener<ChangePasswordViewModel, ChangePasswordBaseState>(
                  listenWhen: (previous, current) => previous != current,
                  listener: (context, state) {
                    if (state.isChangingPassword == false) {
                      if (state.didChangePasswordfail) {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(localizations.error),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Text(localizations.incorrect_password),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(localizations.ok),
                                  onPressed: () {
                                    context.pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(localizations.success),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Text(
                                      localizations.password_changed_success,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(localizations.ok),
                                  onPressed: () {
                                    context.pop();
                                    context.pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Form(
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
                                return localizations
                                    .confirm_password_is_required;
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
                            child:
                                BlocBuilder<
                                  ChangePasswordViewModel,
                                  ChangePasswordBaseState
                                >(
                                  builder: (context, state) {
                                    if (state.isChangingPassword) {
                                      return Center(
                                        child: SizedBox(
                                          height: 18.h,
                                          width: 18.w,
                                          child: CircularProgressIndicator(
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Text(localizations.update);
                                    }
                                  },
                                ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ChangePasswordViewModel>().doEvent(
                                  ChangePasswordEvent(),
                                  oldPassword: currentPasswordController.text,
                                  newPassword: newPasswordController.text,
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
      ),
    );
  }
}
