// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Al-Quran Al-Kreem`
  String get quran {
    return Intl.message(
      'Al-Quran Al-Kreem',
      name: 'quran',
      desc: '',
      args: [],
    );
  }

  /// `Last Read`
  String get lastRead {
    return Intl.message(
      'Last Read',
      name: 'lastRead',
      desc: '',
      args: [],
    );
  }

  /// `Verse Num.`
  String get lastReadVarseNum {
    return Intl.message(
      'Verse Num.',
      name: 'lastReadVarseNum',
      desc: '',
      args: [],
    );
  }

  /// `Search Using Sura Name or The Verse`
  String get searchHint {
    return Intl.message(
      'Search Using Sura Name or The Verse',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Page`
  String get page {
    return Intl.message(
      'Page',
      name: 'page',
      desc: '',
      args: [],
    );
  }

  /// `Hizb`
  String get hizb {
    return Intl.message(
      'Hizb',
      name: 'hizb',
      desc: '',
      args: [],
    );
  }

  /// `Ayas`
  String get ayas {
    return Intl.message(
      'Ayas',
      name: 'ayas',
      desc: '',
      args: [],
    );
  }

  /// `Ayas`
  String get theAyas {
    return Intl.message(
      'Ayas',
      name: 'theAyas',
      desc: '',
      args: [],
    );
  }

  /// `Aya`
  String get aya {
    return Intl.message(
      'Aya',
      name: 'aya',
      desc: '',
      args: [],
    );
  }

  /// `Sorahs`
  String get sorahs {
    return Intl.message(
      'Sorahs',
      name: 'sorahs',
      desc: '',
      args: [],
    );
  }

  /// `Pages`
  String get pages {
    return Intl.message(
      'Pages',
      name: 'pages',
      desc: '',
      args: [],
    );
  }

  /// `Juz`
  String get juz {
    return Intl.message(
      'Juz',
      name: 'juz',
      desc: '',
      args: [],
    );
  }

  /// `Juzes`
  String get juzs {
    return Intl.message(
      'Juzes',
      name: 'juzs',
      desc: '',
      args: [],
    );
  }

  /// `Qurters`
  String get qurter {
    return Intl.message(
      'Qurters',
      name: 'qurter',
      desc: '',
      args: [],
    );
  }

  /// `Next Pray`
  String get nextPray {
    return Intl.message(
      'Next Pray',
      name: 'nextPray',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
