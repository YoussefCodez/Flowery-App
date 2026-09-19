import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';

abstract final class EditProfileValidators {
  static String? validateFirstName(
    String? value,
    AppLocalizations localizations,
  ) {
    if (value == null || value.trim().isEmpty) {
      return localizations.first_name_is_required;
    }
    return null;
  }

  static String? validateLastName(
    String? value,
    AppLocalizations localizations,
  ) {
    if (value == null || value.trim().isEmpty) {
      return localizations.last_name_is_required;
    }
    return null;
  }

  static String? validateEmail(
    String? value,
    AppLocalizations localizations,
  ) {
    if (value == null || value.trim().isEmpty) {
      return localizations.email_is_required;
    }

    if (!AppRegExp.isEmailValid(value)) {
      return localizations.email_is_not_valid;
    }

    return null;
  }

  static String? validatePhone(
    String? value,
    AppLocalizations localizations,
  ) {
    if (value == null || value.trim().isEmpty) {
      return localizations.phone_is_required;
    }

    if (!AppRegExp.isEgyptianPhoneNumberValid(value)) {
      return localizations.phone_number_is_not_valid;
    }

    return null;
  }
}