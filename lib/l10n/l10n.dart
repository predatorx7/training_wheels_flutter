import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gen/app_localizations.dart';

extension CommonLocalizations on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  MaterialLocalizations get l10nMaterial => MaterialLocalizations.of(this);
  CupertinoLocalizations get l10nCupertino => CupertinoLocalizations.of(this);
}
