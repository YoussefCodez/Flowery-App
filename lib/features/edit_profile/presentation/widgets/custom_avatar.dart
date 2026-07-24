import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/events/edit_profile_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class CustomAvatar extends StatelessWidget {
  final String? photo;
  const CustomAvatar({super.key, this.photo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [

        // Image Avatar
        CachedNetworkImage(
          imageUrl: photo ?? "",
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 40.r,
            backgroundColor: AppColors.whiteColor,
            backgroundImage: imageProvider,
          ),
          placeholder: (context, url) => CircleAvatar(
            radius: 40.r,
            backgroundColor: AppColors.whiteColor,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              strokeWidth: 2,
            ),
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            radius: 40.r,
            backgroundColor: AppColors.whiteColor,
            child: Icon(Icons.person),
          ),
        ),

        // Change Photo Button
        Container(
          height: 24.h,
          width: 24.w,
          decoration: BoxDecoration(
            color: AppColors.lightPinkColor,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: IconButton(
            onPressed: () async {
              final pickedFile = await pickImage();
              if (pickedFile != null) {
                // ignore: use_build_context_synchronously
                context.read<EditProfileViewModel>().doEvent(
                  UploadProfilePhotoEvent(pickedFile),
                );
              }
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.photo_camera_outlined,
              size: 16.sp,
              color: AppColors.lightGrayColor,
            ),
          ),
        ),
      ],
    );
  }
}

Future<File?> pickImage() async {
  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result == null) return null;
  return File(result.files.single.path!);
}
