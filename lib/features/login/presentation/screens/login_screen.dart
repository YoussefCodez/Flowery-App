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
  // Constructor
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Theme & Localization
  late ThemeData theme;
  late AppLocalizations titles;

  // Fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Validations
  final _formKey = GlobalKey<FormState>();

  // Remember me
  bool? rememberMeChecker = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = Theme.of(context);
    titles = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (context) => getIt.get<LoginViewModel>(),
      child: Builder(
        builder: (context) {
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
                              BlocBuilder<LoginViewModel, LoginStates>(
                                builder: (context, state) {
                                  if (state is LoginInitState) {
                                    // Updating/Listening the rememberMeChecker from the state managment
                                    rememberMeChecker = state.rememberMe;
                                  }

                                  return Checkbox(
                                    value: rememberMeChecker,
                                    onChanged: (value) {
                                      context.read<LoginViewModel>().doEvent(
                                        ToggleRememberMeEvent(),
                                        currentBooleanRememberMe: value,
                                      );
                                    },
                                  );
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
                          Text(
                            titles.forget_password_ques,
                            style: theme.textTheme.labelSmall!.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),

                      // Login button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginViewModel>().doEvent(
                              LoginUserEvent(),
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: BlocConsumer<LoginViewModel, LoginStates>(
                          builder: (BuildContext context, LoginStates state) {
                            if (state is LoginLoadingState) {
                              return SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.whiteColor,
                                ),
                              );
                            }

                            return Text(titles.login);
                          },
                          listener: (context, state) {
                            if (state is LoginSuccessState) {
                              // Save remember me flag value
                              getIt<SharedPrefHelper>().saveString(
                                key: Apikeys.userId,
                                value: rememberMeChecker.toString(),
                              );

                              // Navigate to home
                              context.pushNamed(AppRoutes.home);
                            }

                            if (state is LoginErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
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
                          Text(
                            titles.sign_up,
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
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
