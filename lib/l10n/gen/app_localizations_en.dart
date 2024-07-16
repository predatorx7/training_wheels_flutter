import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Kaagaz';

  @override
  String get languageName => 'English';

  @override
  String get thatsAnError => 'That\'s an error';

  @override
  String get requestedPageNotFound => 'The requested page was not found.';

  @override
  String get thatsAllWeKnow => 'That\'s all we know.';

  @override
  String get home => 'Home';
}
