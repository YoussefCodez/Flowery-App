import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/order_tracking/presentation/screens_helpers/screen_helper_funtions.dart';
import 'package:flutter/material.dart';

class ArrivalTimeContainer extends StatefulWidget {
  final String arrivalTime;
  const ArrivalTimeContainer({super.key, required this.arrivalTime});

  @override
  State<ArrivalTimeContainer> createState() => _ArrivalTimeContainerState();
}

class _ArrivalTimeContainerState extends State<ArrivalTimeContainer> {
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.estimated_arrival,
            style: textTheme.labelSmall?.copyWith(
              decoration: TextDecoration.none,
            ),
          ),
          Text(formatDateString(widget.arrivalTime), style: textTheme.labelLarge),
        ],
      ),
    );
  }
}
