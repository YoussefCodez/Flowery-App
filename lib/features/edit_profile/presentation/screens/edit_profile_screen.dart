import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/events/edit_profile_events.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/states/edit_profile_base_state.dart';
import 'package:flowery/features/edit_profile/presentation/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.edit_profile),
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigate to the notifications screen
            },
            icon: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: BlocProvider<EditProfileViewModel>(
        create: (context) =>
            getIt.get<EditProfileViewModel>()..doEvent(GetLoggedUserEvent()),
        child: BlocBuilder<EditProfileViewModel, EditProfileBaseState>(
          builder: (context, state) {
            print("SCREEN PHOTO = ${state.user?.photo}");
            if (state.isLoadingProfile == true) {
              return Center(
                child: SizedBox(
                  height: 50.h,
                  width: 50.w,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (state.errorMessage != null) {
                return Center(child: Text(localizations.an_error_occurred));
              }
              return Center(
                child: ProfileForm(
                  photo: state.user?.photo,
                  firstName: state.user?.firstName,
                  lastName: state.user?.lastName,
                  email: state.user?.email,
                  phone: state.user?.phone,
                  gender: state.user?.gender,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
