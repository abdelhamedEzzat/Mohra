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

  /// `Enter first name`
  String get nameHintTextInRegisterScreenFirst {
    return Intl.message(
      'Enter first name',
      name: 'nameHintTextInRegisterScreenFirst',
      desc: '',
      args: [],
    );
  }

  /// `Enter Last name`
  String get nameHintTextInRegisterScreenLast {
    return Intl.message(
      'Enter Last name',
      name: 'nameHintTextInRegisterScreenLast',
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

  /// `My Company :`
  String get MyCompany {
    return Intl.message(
      'My Company :',
      name: 'MyCompany',
      desc: '',
      args: [],
    );
  }

  /// `You haven't created any companies yet. Click to create one!`
  String get NoCompanyMassage {
    return Intl.message(
      'You haven\'t created any companies yet. Click to create one!',
      name: 'NoCompanyMassage',
      desc: '',
      args: [],
    );
  }

  /// `Click to Create your Company`
  String get CreateCompany {
    return Intl.message(
      'Click to Create your Company',
      name: 'CreateCompany',
      desc: '',
      args: [],
    );
  }

  /// `Create Company To Start`
  String get CreateCompanyToStart {
    return Intl.message(
      'Create Company To Start',
      name: 'CreateCompanyToStart',
      desc: '',
      args: [],
    );
  }

  /// `LogOut`
  String get LogOut {
    return Intl.message(
      'LogOut',
      name: 'LogOut',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get Delete {
    return Intl.message(
      'Delete account',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `Upload Documents :`
  String get UploadDocuments {
    return Intl.message(
      'Upload Documents :',
      name: 'UploadDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Comments :`
  String get Comments {
    return Intl.message(
      'Comments :',
      name: 'Comments',
      desc: '',
      args: [],
    );
  }

  /// `Add any Comment Here`
  String get hintComments {
    return Intl.message(
      'Add any Comment Here',
      name: 'hintComments',
      desc: '',
      args: [],
    );
  }

  /// `Upload any Document`
  String get UploadanyDocument {
    return Intl.message(
      'Upload any Document',
      name: 'UploadanyDocument',
      desc: '',
      args: [],
    );
  }

  /// `user in`
  String get userin {
    return Intl.message(
      'user in',
      name: 'userin',
      desc: '',
      args: [],
    );
  }

  /// `add document number`
  String get addDocumentName {
    return Intl.message(
      'add document number',
      name: 'addDocumentName',
      desc: '',
      args: [],
    );
  }

  /// `toReview`
  String get toReview {
    return Intl.message(
      'toReview',
      name: 'toReview',
      desc: '',
      args: [],
    );
  }

  /// `user`
  String get user {
    return Intl.message(
      'user',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `UserNotification`
  String get UserNotification {
    return Intl.message(
      'UserNotification',
      name: 'UserNotification',
      desc: '',
      args: [],
    );
  }

  /// `Wating for Review`
  String get WatingforReview {
    return Intl.message(
      'Wating for Review',
      name: 'WatingforReview',
      desc: '',
      args: [],
    );
  }

  /// `Details Documents`
  String get DetailsDocuments {
    return Intl.message(
      'Details Documents',
      name: 'DetailsDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Create Company`
  String get CreateCompanys {
    return Intl.message(
      'Create Company',
      name: 'CreateCompanys',
      desc: '',
      args: [],
    );
  }

  /// `Add Logo`
  String get AddLogo {
    return Intl.message(
      'Add Logo',
      name: 'AddLogo',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get CompanyName {
    return Intl.message(
      'Company Name',
      name: 'CompanyName',
      desc: '',
      args: [],
    );
  }

  /// `*this Field is Requierd`
  String get FeildRequierd {
    return Intl.message(
      '*this Field is Requierd',
      name: 'FeildRequierd',
      desc: '',
      args: [],
    );
  }

  /// `Please enter only letters`
  String get LattersOnly {
    return Intl.message(
      'Please enter only letters',
      name: 'LattersOnly',
      desc: '',
      args: [],
    );
  }

  /// `Write Your Company Name`
  String get hintNameCompany {
    return Intl.message(
      'Write Your Company Name',
      name: 'hintNameCompany',
      desc: '',
      args: [],
    );
  }

  /// `Company Adrdress`
  String get CompanyAdrdress {
    return Intl.message(
      'Company Adrdress',
      name: 'CompanyAdrdress',
      desc: '',
      args: [],
    );
  }

  /// `Write  Your Company Address`
  String get hintAddressCompany {
    return Intl.message(
      'Write  Your Company Address',
      name: 'hintAddressCompany',
      desc: '',
      args: [],
    );
  }

  /// ` Company Type`
  String get CompanyType {
    return Intl.message(
      ' Company Type',
      name: 'CompanyType',
      desc: '',
      args: [],
    );
  }

  /// `Write  Your Company Type`
  String get hintCompanyType {
    return Intl.message(
      'Write  Your Company Type',
      name: 'hintCompanyType',
      desc: '',
      args: [],
    );
  }

  /// ` Please select an image.`
  String get MustSelectImage {
    return Intl.message(
      ' Please select an image.',
      name: 'MustSelectImage',
      desc: '',
      args: [],
    );
  }

  /// `Choose how to upload the image`
  String get chooseHowUploadImage {
    return Intl.message(
      'Choose how to upload the image',
      name: 'chooseHowUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Camera `
  String get Camera {
    return Intl.message(
      'Camera ',
      name: 'Camera',
      desc: '',
      args: [],
    );
  }

  /// ` Galarey`
  String get Galarey {
    return Intl.message(
      ' Galarey',
      name: 'Galarey',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `Company Documents`
  String get CompanyDocuments {
    return Intl.message(
      'Company Documents',
      name: 'CompanyDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Company Details`
  String get CompanyDetails {
    return Intl.message(
      'Company Details',
      name: 'CompanyDetails',
      desc: '',
      args: [],
    );
  }

  /// `Name :`
  String get Name {
    return Intl.message(
      'Name :',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Address :`
  String get Address {
    return Intl.message(
      'Address :',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Type :`
  String get Type {
    return Intl.message(
      'Type :',
      name: 'Type',
      desc: '',
      args: [],
    );
  }

  /// `My Document :`
  String get MyDocument {
    return Intl.message(
      'My Document :',
      name: 'MyDocument',
      desc: '',
      args: [],
    );
  }

  /// `You didn't have any documents.`
  String get DidntHaveDocument {
    return Intl.message(
      'You didn\'t have any documents.',
      name: 'DidntHaveDocument',
      desc: '',
      args: [],
    );
  }

  /// `Upload Document `
  String get UploadDocument {
    return Intl.message(
      'Upload Document ',
      name: 'UploadDocument',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Search For Company`
  String get SearchForCompany {
    return Intl.message(
      'Search For Company',
      name: 'SearchForCompany',
      desc: '',
      args: [],
    );
  }

  /// `Select Type Of Document`
  String get SelectTypeOfDocument {
    return Intl.message(
      'Select Type Of Document',
      name: 'SelectTypeOfDocument',
      desc: '',
      args: [],
    );
  }

  /// `No Data Available`
  String get NoDataAvailable {
    return Intl.message(
      'No Data Available',
      name: 'NoDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Write any thing to search`
  String get Writeanythingtosearch {
    return Intl.message(
      'Write any thing to search',
      name: 'Writeanythingtosearch',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get SearchScreen {
    return Intl.message(
      'Search...',
      name: 'SearchScreen',
      desc: '',
      args: [],
    );
  }

  /// `My available companies :`
  String get MyAvailableCompanies {
    return Intl.message(
      'My available companies :',
      name: 'MyAvailableCompanies',
      desc: '',
      args: [],
    );
  }

  /// `No available companies.`
  String get NoAvailableCompanies {
    return Intl.message(
      'No available companies.',
      name: 'NoAvailableCompanies',
      desc: '',
      args: [],
    );
  }

  /// `amendment`
  String get amendment {
    return Intl.message(
      'amendment',
      name: 'amendment',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get Finished {
    return Intl.message(
      'Finished',
      name: 'Finished',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get Canceled {
    return Intl.message(
      'Canceled',
      name: 'Canceled',
      desc: '',
      args: [],
    );
  }

  /// `acceptable`
  String get acceptable {
    return Intl.message(
      'acceptable',
      name: 'acceptable',
      desc: '',
      args: [],
    );
  }

  /// `Upload From User : `
  String get UploadFromUser {
    return Intl.message(
      'Upload From User : ',
      name: 'UploadFromUser',
      desc: '',
      args: [],
    );
  }

  /// `Review : `
  String get Review {
    return Intl.message(
      'Review : ',
      name: 'Review',
      desc: '',
      args: [],
    );
  }

  /// `Select Status Of Document`
  String get SelectStatusOfDocument {
    return Intl.message(
      'Select Status Of Document',
      name: 'SelectStatusOfDocument',
      desc: '',
      args: [],
    );
  }

  /// `invoiceDate :`
  String get invoiceDate {
    return Intl.message(
      'invoiceDate :',
      name: 'invoiceDate',
      desc: '',
      args: [],
    );
  }

  /// `invoiceNumber :`
  String get invoiceNumber {
    return Intl.message(
      'invoiceNumber :',
      name: 'invoiceNumber',
      desc: '',
      args: [],
    );
  }

  /// `select Item :`
  String get selectItem {
    return Intl.message(
      'select Item :',
      name: 'selectItem',
      desc: '',
      args: [],
    );
  }

  /// `select Type Item :`
  String get selectTypeItem {
    return Intl.message(
      'select Type Item :',
      name: 'selectTypeItem',
      desc: '',
      args: [],
    );
  }

  /// `amount Of The Invoice :`
  String get amountOfTheInvoice {
    return Intl.message(
      'amount Of The Invoice :',
      name: 'amountOfTheInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Staff Type Review :`
  String get StaffTypeReview {
    return Intl.message(
      'Staff Type Review :',
      name: 'StaffTypeReview',
      desc: '',
      args: [],
    );
  }

  /// `Document Status :`
  String get DocumentStatus {
    return Intl.message(
      'Document Status :',
      name: 'DocumentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Please write a comment`
  String get PleaseWriteaComment {
    return Intl.message(
      'Please write a comment',
      name: 'PleaseWriteaComment',
      desc: '',
      args: [],
    );
  }

  /// `Auditor`
  String get Auditor {
    return Intl.message(
      'Auditor',
      name: 'Auditor',
      desc: '',
      args: [],
    );
  }

  /// `Auditor Review your Document in`
  String get AuditorReviewyourDocumentin {
    return Intl.message(
      'Auditor Review your Document in',
      name: 'AuditorReviewyourDocumentin',
      desc: '',
      args: [],
    );
  }

  /// `with`
  String get witha {
    return Intl.message(
      'with',
      name: 'witha',
      desc: '',
      args: [],
    );
  }

  /// `You Must add Status Of Document`
  String get YouMustaddStatusOfDocument {
    return Intl.message(
      'You Must add Status Of Document',
      name: 'YouMustaddStatusOfDocument',
      desc: '',
      args: [],
    );
  }

  /// `Add Document Type`
  String get AddDocumentType {
    return Intl.message(
      'Add Document Type',
      name: 'AddDocumentType',
      desc: '',
      args: [],
    );
  }

  /// `Company document not found`
  String get Companydocumentnotfound {
    return Intl.message(
      'Company document not found',
      name: 'Companydocumentnotfound',
      desc: '',
      args: [],
    );
  }

  /// `EnterType`
  String get EnterType {
    return Intl.message(
      'EnterType',
      name: 'EnterType',
      desc: '',
      args: [],
    );
  }

  /// `Add Type of Document Company`
  String get AddTypeofDocumentCompany {
    return Intl.message(
      'Add Type of Document Company',
      name: 'AddTypeofDocumentCompany',
      desc: '',
      args: [],
    );
  }

  /// `Controller`
  String get Controller {
    return Intl.message(
      'Controller',
      name: 'Controller',
      desc: '',
      args: [],
    );
  }

  /// `Companys`
  String get Companys {
    return Intl.message(
      'Companys',
      name: 'Companys',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get Users {
    return Intl.message(
      'Users',
      name: 'Users',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get Staff {
    return Intl.message(
      'Staff',
      name: 'Staff',
      desc: '',
      args: [],
    );
  }

  /// `Sttaf Assignment`
  String get Assignment {
    return Intl.message(
      'Sttaf Assignment',
      name: 'Assignment',
      desc: '',
      args: [],
    );
  }

  /// `Select Staff Type`
  String get SelectStaffType {
    return Intl.message(
      'Select Staff Type',
      name: 'SelectStaffType',
      desc: '',
      args: [],
    );
  }

  /// `Write Name to Accountant or Auditor`
  String get hintAssignmentStaffName {
    return Intl.message(
      'Write Name to Accountant or Auditor',
      name: 'hintAssignmentStaffName',
      desc: '',
      args: [],
    );
  }

  /// `You added`
  String get YouAdded {
    return Intl.message(
      'You added',
      name: 'YouAdded',
      desc: '',
      args: [],
    );
  }

  /// `to be`
  String get tobe {
    return Intl.message(
      'to be',
      name: 'tobe',
      desc: '',
      args: [],
    );
  }

  /// `to it`
  String get toit {
    return Intl.message(
      'to it',
      name: 'toit',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `New Auditor`
  String get NewAuditor {
    return Intl.message(
      'New Auditor',
      name: 'NewAuditor',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get Pleaseentersometext {
    return Intl.message(
      'Please enter some text',
      name: 'Pleaseentersometext',
      desc: '',
      args: [],
    );
  }

  /// `The email must contain at least one letter.`
  String get Theemailmustcontainatleastoneletter {
    return Intl.message(
      'The email must contain at least one letter.',
      name: 'Theemailmustcontainatleastoneletter',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain  numbers, letters, and special character.`
  String get Passwordmustcontainnumberslettersandspecialcharacter {
    return Intl.message(
      'Password must contain  numbers, letters, and special character.',
      name: 'Passwordmustcontainnumberslettersandspecialcharacter',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get CreateAccount {
    return Intl.message(
      'Create Account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `New Accountant`
  String get NewAccountant {
    return Intl.message(
      'New Accountant',
      name: 'NewAccountant',
      desc: '',
      args: [],
    );
  }

  /// `Choose Filter`
  String get ChooseFilter {
    return Intl.message(
      'Choose Filter',
      name: 'ChooseFilter',
      desc: '',
      args: [],
    );
  }

  /// `your Company`
  String get yourCompany {
    return Intl.message(
      'your Company',
      name: 'yourCompany',
      desc: '',
      args: [],
    );
  }

  /// `Has been Rejected`
  String get HasbeenRejected {
    return Intl.message(
      'Has been Rejected',
      name: 'HasbeenRejected',
      desc: '',
      args: [],
    );
  }

  /// `Has been Accepted`
  String get HasbeenAccepted {
    return Intl.message(
      'Has been Accepted',
      name: 'HasbeenAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Add New Accountatnt`
  String get AddNewAccountatnt {
    return Intl.message(
      'Add New Accountatnt',
      name: 'AddNewAccountatnt',
      desc: '',
      args: [],
    );
  }

  /// `Add New Auditor`
  String get AddNewAuditor {
    return Intl.message(
      'Add New Auditor',
      name: 'AddNewAuditor',
      desc: '',
      args: [],
    );
  }

  /// `Manage Assignment`
  String get ManageAssignment {
    return Intl.message(
      'Manage Assignment',
      name: 'ManageAssignment',
      desc: '',
      args: [],
    );
  }

  /// `You didn't have any documents.`
  String get Youdidnthaveanydocuments {
    return Intl.message(
      'You didn\'t have any documents.',
      name: 'Youdidnthaveanydocuments',
      desc: '',
      args: [],
    );
  }

  /// `email :`
  String get email {
    return Intl.message(
      'email :',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `UserName`
  String get UserName {
    return Intl.message(
      'UserName',
      name: 'UserName',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get Accepted {
    return Intl.message(
      'Accepted',
      name: 'Accepted',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get Rejected {
    return Intl.message(
      'Rejected',
      name: 'Rejected',
      desc: '',
      args: [],
    );
  }

  /// `No documents found for you`
  String get Nodocumentsfoundforyou {
    return Intl.message(
      'No documents found for you',
      name: 'Nodocumentsfoundforyou',
      desc: '',
      args: [],
    );
  }

  /// `Write Company name`
  String get WriteCompanyname {
    return Intl.message(
      'Write Company name',
      name: 'WriteCompanyname',
      desc: '',
      args: [],
    );
  }

  /// `Type Invoice date`
  String get TypeInvoicedate {
    return Intl.message(
      'Type Invoice date',
      name: 'TypeInvoicedate',
      desc: '',
      args: [],
    );
  }

  /// `Type invoice number`
  String get Typeinvoicenumber {
    return Intl.message(
      'Type invoice number',
      name: 'Typeinvoicenumber',
      desc: '',
      args: [],
    );
  }

  /// `Type Amount of the invoice`
  String get TypeAmountoftheinvoice {
    return Intl.message(
      'Type Amount of the invoice',
      name: 'TypeAmountoftheinvoice',
      desc: '',
      args: [],
    );
  }

  /// `Accountant added Document in`
  String get AccountantaddedDocumentin {
    return Intl.message(
      'Accountant added Document in',
      name: 'AccountantaddedDocumentin',
      desc: '',
      args: [],
    );
  }

  /// `You Must add Type Of Document`
  String get YouMustaddTypeOfDocument {
    return Intl.message(
      'You Must add Type Of Document',
      name: 'YouMustaddTypeOfDocument',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get ManageSubmit {
    return Intl.message(
      'Submit',
      name: 'ManageSubmit',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account you areagreeing toour\n`
  String get Bycreatinganaccountyouareagreeingtoour {
    return Intl.message(
      'By creating an account you areagreeing toour\n',
      name: 'Bycreatinganaccountyouareagreeingtoour',
      desc: '',
      args: [],
    );
  }

  /// `Termes & Condations`
  String get TermesCondations {
    return Intl.message(
      'Termes & Condations',
      name: 'TermesCondations',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get and {
    return Intl.message(
      ' and ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `The accountant has been added successfully`
  String get TheAccountantHasBeenAddedSuccessfully {
    return Intl.message(
      'The accountant has been added successfully',
      name: 'TheAccountantHasBeenAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `The Auditor Has Been Added Successfully`
  String get TheAuditorantHasBeenAddedSuccessfully {
    return Intl.message(
      'The Auditor Has Been Added Successfully',
      name: 'TheAuditorantHasBeenAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `It has been successfully added`
  String get Ithasbeensuccessfully {
    return Intl.message(
      'It has been successfully added',
      name: 'Ithasbeensuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `added to the company`
  String get addedtothecompany {
    return Intl.message(
      'added to the company',
      name: 'addedtothecompany',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours you cant do anythink after accepted. `
  String get adminstrationTitleMassage {
    return Intl.message(
      'Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours you cant do anythink after accepted. ',
      name: 'adminstrationTitleMassage',
      desc: '',
      args: [],
    );
  }

  /// `Hello, your email is in the acceptance stage of administration`
  String get snackParInAdminstrationPage {
    return Intl.message(
      'Hello, your email is in the acceptance stage of administration',
      name: 'snackParInAdminstrationPage',
      desc: '',
      args: [],
    );
  }

  /// `AuditorCompany :`
  String get auditorCompany {
    return Intl.message(
      'AuditorCompany :',
      name: 'auditorCompany',
      desc: '',
      args: [],
    );
  }

  /// `Accountant Company :`
  String get accountantCompany {
    return Intl.message(
      'Accountant Company :',
      name: 'accountantCompany',
      desc: '',
      args: [],
    );
  }

  /// `See Document Company`
  String get SeeDocumentCompany {
    return Intl.message(
      'See Document Company',
      name: 'SeeDocumentCompany',
      desc: '',
      args: [],
    );
  }

  /// `Display data through the accountant screen`
  String get Displaydatathroughtheaccountantscreen {
    return Intl.message(
      'Display data through the accountant screen',
      name: 'Displaydatathroughtheaccountantscreen',
      desc: '',
      args: [],
    );
  }

  /// `Display data through the Auditor screen`
  String get DisplaydatathroughtheAuditorscreen {
    return Intl.message(
      'Display data through the Auditor screen',
      name: 'DisplaydatathroughtheAuditorscreen',
      desc: '',
      args: [],
    );
  }

  /// `Accountat Company`
  String get AccountatCompany {
    return Intl.message(
      'Accountat Company',
      name: 'AccountatCompany',
      desc: '',
      args: [],
    );
  }

  /// `Auditor Company`
  String get AuditorCompany {
    return Intl.message(
      'Auditor Company',
      name: 'AuditorCompany',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get ConfirmLogout {
    return Intl.message(
      'Confirm Logout',
      name: 'ConfirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get Areyousureyouwanttologout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'Areyousureyouwanttologout',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Number of company documents`
  String get Numberofcompanydocuments {
    return Intl.message(
      'Number of company documents',
      name: 'Numberofcompanydocuments',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Account Deletion`
  String get ConfirmAccountDeletion {
    return Intl.message(
      'Confirm Account Deletion',
      name: 'ConfirmAccountDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get Areyousureyouwanttodeleteyouraccount {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'Areyousureyouwanttodeleteyouraccount',
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
