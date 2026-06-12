import 'package:flowery/config/general_cubit/local_cubit.dart';
import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/config/utils/constants.dart';
import 'package:flowery/core/const/edit_profile_values.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/events/edit_profile_events.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/states/edit_profile_base_state.dart';
import 'package:flowery/features/edit_profile/presentation/widgets/custom_avatar.dart';
import 'package:flowery/features/edit_profile/presentation/widgets/custom_password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileForm extends StatefulWidget {
  final String? photo;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? gender;

  const ProfileForm({
    super.key,
    required this.photo,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late String? gender;
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    passwordController = TextEditingController(text: localizations.stars);
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    gender = widget.gender;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BlocBuilder<EditProfileViewModel, EditProfileBaseState>(
              builder: (context, state) {
                return CustomAvatar(photo: state.user?.photo);
              },
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: MainTextField(
                    hintText: localizations.first_name,
                    labelText: localizations.first_name,
                    controller: firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.first_name_is_required;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: MainTextField(
                    hintText: localizations.last_name,
                    labelText: localizations.last_name,
                    controller: lastNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.last_name_is_required;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            MainTextField(
              hintText: localizations.email,
              labelText: localizations.email,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.email_is_required;
                }
                if (!AppRegExp.isEmailValid(value)) {
                  return localizations.email_is_not_valid;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            MainTextField(
              hintText: localizations.phone,
              labelText: localizations.phone,
              controller: phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.phone_is_required;
                }
                if (!AppRegExp.isEgyptianPhoneNumberValid(value)) {
                  return localizations.phone_number_is_not_valid;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            Stack(
              alignment:
                  context.read<LocaleThemeCubit>().loadCurrentLanguage() ==
                      AppConstants.arKey
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              children: [
                CustomPasswordTextField(
                  controller: passwordController,
                  hintText: localizations.password,
                  labelText: localizations.password,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => context.pushNamed(AppRoutes.changePassword),
                    child: Text(
                      localizations.change,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  localizations.gender,
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 50.w),
                Row(
                  children: [
                    RadioMenuButton(
                      value: EditProfileValues.male,
                      groupValue: gender,
                      onChanged: (_) {},
                      child: Text(localizations.male),
                    ),
                    RadioMenuButton(
                      value: EditProfileValues.female,
                      groupValue: gender,
                      onChanged: (_) {},
                      child: Text(localizations.female),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50.h),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<EditProfileViewModel>().doEvent(
                    UpdateLoggedUserEvent(),
                    user: EditUserModel(
                      firstName: firstNameController.text,
                      email: emailController.text,
                      lastName: lastNameController.text,
                      phone: phoneController.text,
                    ),
                  );
                }
              },
              child: Text(localizations.update),
            ),
          ],
        ),
      ),
    );
  }
}
