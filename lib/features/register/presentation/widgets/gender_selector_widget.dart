import 'package:flowery/config/general_cubit/constants.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/register/presentation/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/cubit/register_events.dart';
import 'package:flowery/features/register/presentation/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectorWidget extends StatelessWidget {
  final RegisterCubit cubit;

  const GenderSelectorWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocBuilder<RegisterCubit, RegisterStates>(
      bloc: cubit,
      builder: (_, state) {
        return Row(
          children: [
            Text(localizations.gender),
            const SizedBox(width: 20),
            RadioGroup<String>(
              groupValue: state.gender,
              onChanged: (v) {
                if (v != null) cubit.doIntent(GenderChanged(v));
              },
              child: Row(
                children: [
                  Radio<String>(value: AppConstants.femaleValue),
                  Text(localizations.female),
                  Radio<String>(value: AppConstants.maleValue),
                  Text(localizations.male),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
