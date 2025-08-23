import 'package:flutter/cupertino.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ErrorMapper {
  static String? map(BuildContext context, String? code) {
    if (code == null) return null;

    final l10n = AppLocalizations.of(context);

    switch (code) {
      case 'error_name_required':
        return l10n?.error_name;
      case 'error_username_invalid':
        return l10n?.error_username;
      case 'error_email_invalid':
        return l10n?.error_email;
      case 'error_phone_invalid':
        return l10n?.error_phone;
      default:
        return null; // or a default error message
    }
  }
}