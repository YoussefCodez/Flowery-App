import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/order_tracking/presentation/screens_assets/order_screen_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DriverInfoContainer extends StatefulWidget {
  final String driverFirstName;
  final String driverLastName;
  final String driverPhoneNumber;
  final String driverImage;
  const DriverInfoContainer({
    super.key,
    required this.driverFirstName,
    required this.driverLastName,
    required this.driverPhoneNumber,
    required this.driverImage,
  });

  @override
  State<DriverInfoContainer> createState() => _DriverInfoContainerState();
}

class _DriverInfoContainerState extends State<DriverInfoContainer> {
  late AppLocalizations localizations;
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 30,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.driverImage.isEmpty
                  ? Image.asset(OrderScreenAssets.driver, scale: 2)
                  : SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: CachedNetworkImage(imageUrl: widget.driverImage),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.driverFirstName} ${widget.driverLastName}"),
                  Text(localizations.delivery_hero_for_today),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.call_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(OrderScreenAssets.car),
          ),
        ],
      ),
    );
  }
}
