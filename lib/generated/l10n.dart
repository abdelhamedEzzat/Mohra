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

  /// `Manging Your documents`
  String get titleForFirstIntroScreen {
    return Intl.message(
      'Manging Your documents',
      name: 'titleForFirstIntroScreen',
      desc: '',
      args: [],
    );
  }

  /// `You can easily upload documents, follow the progress of work on them, and you can also write comments`
  String get subtitleForFirstIntroScreen {
    return Intl.message(
      'You can easily upload documents, follow the progress of work on them, and you can also write comments',
      name: 'subtitleForFirstIntroScreen',
      desc: '',
      args: [],
    );
  }

  /// `Review Your documents`
  String get titleForSecondIntroScreen {
    return Intl.message(
      'Review Your documents',
      name: 'titleForSecondIntroScreen',
      desc: '',
      args: [],
    );
  }

  /// `You can easily upload your documents and have them reviewed by specialized accountants and auditors `
  String get subtitleForSecondIntroScreen {
    return Intl.message(
      'You can easily upload your documents and have them reviewed by specialized accountants and auditors ',
      name: 'subtitleForSecondIntroScreen',
      desc: '',
      args: [],
    );
  }

  /// `Register And Save Data`
  String get titleForThirdIntroScreen {
    return Intl.message(
      'Register And Save Data',
      name: 'titleForThirdIntroScreen',
      desc: '',
      args: [],
    );
  }

  /// `You can keep the uploaded documents, see them at any time, and filter the documents according to their status`
  String get subtitleForThirdIntroScreen {
    return Intl.message(
      'You can keep the uploaded documents, see them at any time, and filter the documents according to their status',
      name: 'subtitleForThirdIntroScreen',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get buttonNameFirstAndSecoundIntroScreen {
    return Intl.message(
      'Next',
      name: 'buttonNameFirstAndSecoundIntroScreen',
      desc: '',
      args: [],
    );
  }

  /// `Click To Start`
  String get buttonNameThirdIntroScreen {
    return Intl.message(
      'Click To Start',
      name: 'buttonNameThirdIntroScreen',
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
