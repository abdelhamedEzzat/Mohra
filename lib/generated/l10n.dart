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

  /// `Register Account `
  String get registerAccount {
    return Intl.message(
      'Register Account ',
      name: 'registerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabelTextInRegisterScreen {
    return Intl.message(
      'Email',
      name: 'emailLabelTextInRegisterScreen',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get emailHintTextInRegisterScreen {
    return Intl.message(
      'Enter Your Email',
      name: 'emailHintTextInRegisterScreen',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabelTextInRegisterScreen {
    return Intl.message(
      'Password',
      name: 'passwordLabelTextInRegisterScreen',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Pasword`
  String get passwordHintTextInRegisterScreen {
    return Intl.message(
      'Enter Your Pasword',
      name: 'passwordHintTextInRegisterScreen',
      desc: '',
      args: [],
    );
  }

  /// `first Name`
  String get firstnameLabelTextInRegisterScreen {
    return Intl.message(
      'first Name',
      name: 'firstnameLabelTextInRegisterScreen',
      desc: '',
      args: [],
    );
  }

  /// `last Name`
  String get lastnameLabelTextInRegisterScreen {
    return Intl.message(
      'last Name',
      name: 'lastnameLabelTextInRegisterScreen',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get nameHintTextInRegisterScreen {
    return Intl.message(
      'Enter Your Name',
      name: 'nameHintTextInRegisterScreen',
      desc: '',
      args: [],
    );
  }

  /// `Register Account`
  String get registerAccountBotton {
    return Intl.message(
      'Register Account',
      name: 'registerAccountBotton',
      desc: '',
      args: [],
    );
  }

  /// `Register with google`
  String get registerAccountBottonByGoogle {
    return Intl.message(
      'Register with google',
      name: 'registerAccountBottonByGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Already Have Account? `
  String get AlreadyHaveAccount {
    return Intl.message(
      'Already Have Account? ',
      name: 'AlreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login `
  String get loginAccount {
    return Intl.message(
      'Login ',
      name: 'loginAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginAccountBotton {
    return Intl.message(
      'Login',
      name: 'loginAccountBotton',
      desc: '',
      args: [],
    );
  }

  /// `Login with google`
  String get loginAccountBottonByGoogle {
    return Intl.message(
      'Login with google',
      name: 'loginAccountBottonByGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Didnt Have Account? `
  String get didntHaveAccount {
    return Intl.message(
      'Didnt Have Account? ',
      name: 'didntHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password ?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password ?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get sendRequest {
    return Intl.message(
      'Send Request',
      name: 'sendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get ContinueAfterSendVerify {
    return Intl.message(
      'Continue',
      name: 'ContinueAfterSendVerify',
      desc: '',
      args: [],
    );
  }

  /// `Verify your email address`
  String get Verifyyouremailaddress {
    return Intl.message(
      'Verify your email address',
      name: 'Verifyyouremailaddress',
      desc: '',
      args: [],
    );
  }

  /// `We have just send email verification link on your email , please check email and click on that link to verify your email address`
  String get SubTitleVerify {
    return Intl.message(
      'We have just send email verification link on your email , please check email and click on that link to verify your email address',
      name: 'SubTitleVerify',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get Home {
    return Intl.message(
      'home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get Notification {
    return Intl.message(
      'Notification',
      name: 'Notification',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Companies`
  String get Companies {
    return Intl.message(
      'Companies',
      name: 'Companies',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get Documents {
    return Intl.message(
      'Documents',
      name: 'Documents',
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
