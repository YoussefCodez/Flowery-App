import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/core/const/app_strings.dart';
import 'package:flowery/core/const/app_svgs.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/featuers/main_profile/domain/entity/profile_entity.dart';
import 'package:flowery/featuers/main_profile/presentation/view_model/profile_cubit.dart';
import 'package:flowery/featuers/main_profile/presentation/view_model/profile_event.dart';
import 'package:flowery/featuers/main_profile/presentation/view_model/profile_state.dart';
import 'package:flowery/featuers/main_profile/presentation/widget/custom_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class MainProfileView extends StatefulWidget {
  const MainProfileView({super.key});

  @override
  State<MainProfileView> createState() => _MainProfileViewState();
}

class _MainProfileViewState extends State<MainProfileView> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..doEvent(GetProfileDate()),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.getProfileDate.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (profile) => _buildContent(context, profile),
                error: (e) => Center(child: Text(e.toString())),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileEntity profile) {
    final l10n = AppLocalizations.of(context)!;
    final fullName = '${profile.firstName ?? ''} ${profile.lastName ?? ''}'
        .trim();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(AppSvgs.logo, height: 30.h),
              Badge(
                label: const Text('3'),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 25.w,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        CircleAvatar(
          radius: 50.r,
          backgroundColor: AppColors.hintGrayColor,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: profile.photo ?? '',
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
              placeholder: (_, _) =>
                  const CircularProgressIndicator(strokeWidth: 2),
              errorWidget: (_, _, _) =>
                  Icon(Icons.person, size: 40.r, color: AppColors.whiteColor),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fullName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.edit_outlined, size: 16.sp, color: AppColors.grayColor),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          profile.email ?? '',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grayColor,
          ),
        ),
        SizedBox(height: 24.h),
        CustomProfile(
          leadingIcon: Icon(
            Icons.receipt_long_outlined,
            size: 20.sp,
            color: AppColors.blackColor,
          ),
          title: l10n.my_orders,
          trailingWidget: Icon(Icons.chevron_right, color: AppColors.grayColor),
          onTap: () {},
        ),
        CustomProfile(
          leadingIcon: Icon(
            Icons.location_on_outlined,
            size: 20.sp,
            color: AppColors.blackColor,
          ),
          title: l10n.saved_address,
          trailingWidget: Icon(Icons.chevron_right, color: AppColors.grayColor),
          onTap: () {},
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.dividerColor),
        CustomProfile(
          leadingIcon: CupertinoSwitch(
            value: _notificationsEnabled,
            activeTrackColor: AppColors.primaryColor,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          title: l10n.notification,
          trailingWidget: Icon(Icons.chevron_right, color: AppColors.grayColor),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.dividerColor),
        CustomProfile(
          leadingIcon: Icon(
            Icons.translate,
            size: 20.sp,
            color: AppColors.blackColor,
          ),
          title: l10n.language,
          trailingWidget: Text(
            l10n.english,
            style: TextStyle(fontSize: 14.sp, color: AppColors.primaryColor),
          ),
        ),
        CustomProfile(
          title: l10n.about_us,
          trailingWidget: Icon(Icons.chevron_right, color: AppColors.grayColor),
          onTap: () {},
        ),
        CustomProfile(
          title: l10n.terms_and_conditions,
          trailingWidget: Icon(Icons.chevron_right, color: AppColors.grayColor),
          onTap: () {},
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.dividerColor),
        CustomProfile(
          leadingIcon: Icon(
            Icons.exit_to_app,
            size: 20.sp,
            color: AppColors.blackColor,
          ),
          title: l10n.logout,
          trailingWidget: Icon(
            Icons.logout,
            size: 20.sp,
            color: AppColors.blackColor,
          ),
          onTap: () {},
        ),
        const Spacer(),
        Text(
          AppStrings.appVersion,
          style: TextStyle(fontSize: 12.sp, color: AppColors.hintGrayColor),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
