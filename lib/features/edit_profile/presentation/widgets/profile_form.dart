import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flowery/features/edit_profile/data/models/requests/edit_user_model.dart';
import 'package:flowery/features/edit_profile/domain/entities/user_entity.dart';
import 'package:flowery/features/edit_profile/presentation/helpers/edit_profile_validators.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/events/edit_profile_events.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/states/edit_profile_base_state.dart';
import 'package:flowery/features/edit_profile/presentation/widgets/custom_avatar.dart';
import 'package:flowery/features/edit_profile/presentation/widgets/gender_card.dart';
import 'package:flowery/features/edit_profile/presentation/widgets/password_field_with_change_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileForm extends StatefulWidget {
  final UserEntity user;
  final AppLocalizations localizations;
  const ProfileForm({
    super.key,
    required this.user,
    required this.localizations,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

@override
State<ProfileForm> createState() => _ProfileFormState();

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late String gender;

  @override
  initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone);
    passwordController = TextEditingController(
      text: widget.localizations.stars,
    );
    gender = widget.user.gender;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // User Photo
              BlocBuilder<EditProfileViewModel, EditProfileBaseState>(
                builder: (context, state) {
                  return CustomAvatar(
                    photo: state.uploadNewPhotoState.data?.photo,
                  );
                },
              ),
              SizedBox(height: 20.h),

              // Name Fields
              Row(
                children: [
                  Expanded(
                    child: MainTextField(
                      hintText: widget.localizations.first_name,
                      labelText: widget.localizations.first_name,
                      controller: firstNameController,
validator: (value) =>
    EditProfileValidators.validateFirstName(
      value,
      widget.localizations,
    ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: MainTextField(
                      hintText: widget.localizations.last_name,
                      labelText: widget.localizations.last_name,
                      controller: lastNameController,
validator: (value) =>
    EditProfileValidators.validateLastName(
      value,
      widget.localizations,
    ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Email Field
              MainTextField(
                hintText: widget.localizations.email,
                labelText: widget.localizations.email,
                controller: emailController,
validator: (value) =>
    EditProfileValidators.validateEmail(
      value,
      widget.localizations,
    ),
              ),
              SizedBox(height: 20.h),

              // Phone Field
              MainTextField(
                hintText: widget.localizations.phone,
                labelText: widget.localizations.phone,
                controller: phoneController,
validator: (value) =>
    EditProfileValidators.validatePhone(
      value,
      widget.localizations,
    ),
              ),
              SizedBox(height: 20.h),

              // Password Field with Change option
              PasswordFieldWithChangeOption(
                passwordController: passwordController,
                localizations: widget.localizations,
              ),
              SizedBox(height: 20.h),

              // Gender Card
              GenderCard(localizations: widget.localizations, gender: gender),
              SizedBox(height: 50.h),

              // Update Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<EditProfileViewModel>().doEvent(
                      UpdateLoggedUserEvent(
                        EditUserModel(
                          firstName: firstNameController.text,
                          email: emailController.text,
                          lastName: lastNameController.text,
                          phone: phoneController.text,
                        ),
                      ),
                    );
                  }
                },
                child: Text(widget.localizations.update),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
