import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';

class CheckoutValidators {
  static String? validateName(
    String? value,
    AppLocalizations localizations,
  ) {
    if (value == null || value.isEmpty) {
      return localizations.name_is_required;
    }
    return null;
  }

  static String? validatePhone(
    String? value,
    AppLocalizations localizations,
  ) {
    if (value == null || value.isEmpty) {
      return localizations.phone_is_required;
    }
    if (!AppRegExp.isPhoneNumberValid(value)) {
      return localizations.phone_number_is_not_valid;
    }
    return null;
  }
}