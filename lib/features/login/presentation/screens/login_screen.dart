import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/helpers/shared_pref.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flowery/features/login/presentation/view_model/cubit/login_view_model.dart';
import 'package:flowery/features/login/presentation/view_model/events/login_events.dart';
import 'package:flowery/features/login/presentation/view_model/states/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Validations
  final _formKey = GlobalKey<FormState>();

  // Remember me
  bool? rememberMeChecker = false;

  // View Model
  final LoginViewModel viewModel = getIt.get<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titles = AppLocalizations.of(context)!;
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: Scaffold(
        appBar: AppBar(
          title: Text(titles.login, style: theme.textTheme.labelLarge),
          titleSpacing: 0.0,
          leading: SizedBox(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Email TextField
                MainTextField(
                  hintText: titles.enter_your_email,
                  labelText: titles.email,
                  controller: emailController,
                  validator: (value) {
                    if (!AppRegExp.isEmailValid(value!)) {
                      return titles.email_is_not_valid;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Password TextField
                MainTextField(
                  hintText: titles.enter_your_password,
                  labelText: titles.password,
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (!AppRegExp.isPasswordValid(value!)) {
                      return titles.password_is_not_valid;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                // Remember me & Forget password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMeChecker,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberMeChecker = value;
                            });
                          },
                        ),
                        Text(
                          titles.remember_me,
                          style: theme.textTheme.labelSmall!.copyWith(
                            fontSize: 13.sp,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        context.pushNamed(AppRoutes.forgetPassword);
                      },
                      child: Text(
                        titles.forget_password_ques,
                        style: theme.textTheme.labelSmall!.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                // Login button
                BlocProvider<LoginViewModel>(
                  create: (context) => viewModel,
                  child: BlocConsumer<LoginViewModel, LoginStates>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        // Save remember me flag value
                        getIt<SharedPrefHelper>().saveData(
                          key: Apikeys.userId,
                          val: rememberMeChecker.toString(),
                        );

                        // Navigate to home
                        context.pushNamed(AppRoutes.home);
                      }

                      if (state is LoginError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (BuildContext context, LoginStates state) {
                      if (state is LoginLoading) {
                        return CircularProgressIndicator();
                      }

                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            viewModel.doEvent(
                              LoginUserEvent(),
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: Text(titles.login),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titles.don_t_have_an_account,
                      style: theme.textTheme.labelMedium!.copyWith(
                        color: AppColors.blackColor,
                        decoration: TextDecoration.none,
                        fontWeight: .w500,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(titles.sign_up, style: theme.textTheme.labelMedium),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
