import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/core/const/edit_profile_values.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/events/edit_profile_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class CustomAvatar extends StatelessWidget {
  final String? photo;
  CustomAvatar({super.key, this.photo});
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    print("AVATAR PHOTO = $photo");
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
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
        Container(
          height: 24.h,
          width: 24.w,
          decoration: BoxDecoration(
            color: AppColors.lightPinkColor,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: IconButton(
            onPressed: () async {
              final viewModel = context.read<EditProfileViewModel>();

              // Pick an image.
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
              );

              if (image == null) {
                return;
              }

              FormData formData = FormData.fromMap({
                EditProfileValues.photo: await MultipartFile.fromFile(
                  image.path,
                  filename: EditProfileValues.imagePng,
                ),
              });

              viewModel.doEvent(UploadProfilePhotoEvent(), photo: formData);
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
