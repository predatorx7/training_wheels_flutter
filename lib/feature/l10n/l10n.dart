import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeProvider = NotifierProvider<LocaleNotifierProvider, Locale?>(
  LocaleNotifierProvider.new,
);

const _key = '_locale_key';

class LocaleNotifierProvider extends Notifier<Locale?> {
  @override
  Locale? build() {
    hydrate();
    return null;
  }

  late SharedPreferences _prefs;
  late Completer<void> _lock;

  void hydrate() async {
    _lock = Completer<void>();
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs.getString(_key);
    if (value != null) {
      final l10nObject = json.decode(value);
      state = Locale.fromSubtags(
        languageCode: l10nObject['languageCode'],
        countryCode: l10nObject['countryCode'],
        scriptCode: l10nObject['scriptCode'],
      );
    }
    _lock.complete();
  }

  Future<void> update(Locale value) async {
    await _lock.future;
    _lock = Completer<void>();

    state = value;

    await _prefs.setString(
      _key,
      json.encode({
        'languageCode': value.languageCode,
        'countryCode': value.countryCode,
        'scriptCode': value.scriptCode,
      }),
    );
    _lock.complete();
  }
}
