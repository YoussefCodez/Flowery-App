import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/general_cubit/constants.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flowery/features/register/presentation/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/cubit/register_events.dart';
import 'package:flowery/features/register/presentation/cubit/register_states.dart';
import 'package:flowery/features/register/presentation/widgets/gender_selector_widget.dart';
import 'package:flowery/features/register/presentation/widgets/sign_up_button_widget.dart';
import 'package:flowery/features/register/presentation/widgets/term_and_condition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterCubit cubit;

  final _formKey = GlobalKey<FormState>();
  final _firstNameCont = TextEditingController();
  final _lastNameCont = TextEditingController();
  final _emailCont = TextEditingController();
  final _passwordCont = TextEditingController();
  final _confirmPasswordCont = TextEditingController();
  final _phoneCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = getIt<RegisterCubit>();

    cubit.uiEvents.listen((event) {
      if (!mounted) return;

      switch (event) {
        case ShowRegisterLoading():
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => PopScope(
              canPop: false,
              child: AlertDialog(
                backgroundColor: Colors.transparent,
                content: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          );

        case ShowRegisterError():
          Navigator.of(context).pop(); // hide loading
          Fluttertoast.showToast(
            msg: event.message,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
          );

        case NavigateToLogin():
          Navigator.of(context).pop(); // hide loading
          Fluttertoast.showToast(
            msg: AppConstants.accountCreatedSuccessfully,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: AppColors.greenColor,
            textColor: AppColors.whiteColor,
          );
          Navigator.of(context).pushNamed(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(localizations.register),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MainTextField(
                      hintText: localizations.enterFirstName,
                      labelText: localizations.firstName,
                      controller: _firstNameCont,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MainTextField(
                      hintText: localizations.enterLastName,
                      labelText: localizations.lastName,
                      controller: _lastNameCont,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              MainTextField(
                hintText: localizations.enterYourEmail,
                labelText: localizations.email,
                controller: _emailCont,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: MainTextField(
                      hintText: localizations.enterPassword,
                      labelText: localizations.password,
                      controller: _passwordCont,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MainTextField(
                      hintText: localizations.confirm_password,
                      labelText: localizations.confirm_password,
                      controller: _confirmPasswordCont,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              MainTextField(
                hintText: localizations.enterPhoneNumber,
                labelText: localizations.phoneNumber,
                controller: _phoneCont,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 30),
              GenderSelectorWidget(cubit: cubit),
              const SizedBox(height: 12),
              const TermsAndConditionsWidget(),
              const SizedBox(height: 30),
              BlocBuilder<RegisterCubit, RegisterStates>(
                bloc: cubit,
                builder: (_, state) {
                  return SignUpButtonWidget(
                    onPressed: () {
                      cubit.doIntent(
                        SignUpButtonPressed(
                          firstName: _firstNameCont.text,
                          lastName: _lastNameCont.text,
                          email: _emailCont.text,
                          password: _passwordCont.text,
                          confirmPassword: _confirmPasswordCont.text,
                          phoneNumber: _phoneCont.text,
                          gender: state.gender,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameCont.dispose();
    _lastNameCont.dispose();
    _emailCont.dispose();
    _passwordCont.dispose();
    _confirmPasswordCont.dispose();
    _phoneCont.dispose();
    cubit.close();
    super.dispose();
  }
}
