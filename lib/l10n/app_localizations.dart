import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ta')
  ];

  /// No description provided for @signInText.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInText;

  /// No description provided for @appMessage.
  ///
  /// In en, this message translates to:
  /// **'Track your expenses offline and sync securely'**
  String get appMessage;

  /// No description provided for @emailText.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailText;

  /// No description provided for @fourDigitPinText.
  ///
  /// In en, this message translates to:
  /// **'Digit PIN'**
  String get fourDigitPinText;

  /// No description provided for @rememberMeText.
  ///
  /// In en, this message translates to:
  /// **'Remember me?'**
  String get rememberMeText;

  /// No description provided for @forgotPinText.
  ///
  /// In en, this message translates to:
  /// **'Forgot PIN?'**
  String get forgotPinText;

  /// No description provided for @loginText.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginText;

  /// No description provided for @syncMessage.
  ///
  /// In en, this message translates to:
  /// **'Offline mode active. Data will sync automatically'**
  String get syncMessage;

  /// No description provided for @newUserText.
  ///
  /// In en, this message translates to:
  /// **'New User?'**
  String get newUserText;

  /// No description provided for @createAccountText.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountText;

  /// No description provided for @settingsTitleText.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitleText;

  /// No description provided for @appearanceText.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceText;

  /// No description provided for @darkModeText.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkModeText;

  /// No description provided for @darkModeSubtitleText.
  ///
  /// In en, this message translates to:
  /// **'Adjust app theme'**
  String get darkModeSubtitleText;

  /// No description provided for @languageTitleText.
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get languageTitleText;

  /// No description provided for @languageText.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageText;

  /// No description provided for @currencyDisplayText.
  ///
  /// In en, this message translates to:
  /// **'Currency Display'**
  String get currencyDisplayText;

  /// No description provided for @dataSyncDisplayText.
  ///
  /// In en, this message translates to:
  /// **'Data & Sync'**
  String get dataSyncDisplayText;

  /// No description provided for @backgroundSyncTitleText.
  ///
  /// In en, this message translates to:
  /// **'Background Sync'**
  String get backgroundSyncTitleText;

  /// No description provided for @backgroundSyncSubtitleText.
  ///
  /// In en, this message translates to:
  /// **'Update data while online'**
  String get backgroundSyncSubtitleText;

  /// No description provided for @syncTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncTitle;

  /// No description provided for @notificationTitleText.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationTitleText;

  /// No description provided for @dailyRemainderTitleText.
  ///
  /// In en, this message translates to:
  /// **'Daily Remainder'**
  String get dailyRemainderTitleText;

  /// No description provided for @dailyRemainderSubtitleText.
  ///
  /// In en, this message translates to:
  /// **'Remainder at 8PM'**
  String get dailyRemainderSubtitleText;

  /// No description provided for @logoutText.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logoutText;

  /// No description provided for @signupAppMessageText.
  ///
  /// In en, this message translates to:
  /// **'Track your expenses anywhere, even without an internet connection'**
  String get signupAppMessageText;

  /// No description provided for @confirmPinText.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmPinText;

  /// No description provided for @signupText.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signupText;

  /// No description provided for @alreadyAccountText.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyAccountText;

  /// No description provided for @addTransactionText.
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get addTransactionText;

  /// No description provided for @editTransactionText.
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get editTransactionText;

  /// No description provided for @saveText.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveText;

  /// No description provided for @expenseText.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expenseText;

  /// No description provided for @incomeText.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get incomeText;

  /// No description provided for @amountText.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountText;

  /// No description provided for @categoryText.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryText;

  /// No description provided for @dateText.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateText;

  /// No description provided for @notesText.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesText;

  /// No description provided for @addAttachmentText.
  ///
  /// In en, this message translates to:
  /// **'Add Attachment'**
  String get addAttachmentText;

  /// No description provided for @uploadReceiptText.
  ///
  /// In en, this message translates to:
  /// **'Upload receipt or image'**
  String get uploadReceiptText;

  /// No description provided for @transactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionTitle;

  /// No description provided for @dashboardText.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardText;

  /// No description provided for @categoryBreakDownText.
  ///
  /// In en, this message translates to:
  /// **'Category Breakdown'**
  String get categoryBreakDownText;

  /// No description provided for @foodAndBeverageText.
  ///
  /// In en, this message translates to:
  /// **'Food and Groceries'**
  String get foodAndBeverageText;

  /// No description provided for @transportText.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get transportText;

  /// No description provided for @shoppingText.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shoppingText;

  /// No description provided for @utilitiesText.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get utilitiesText;

  /// No description provided for @medicineText.
  ///
  /// In en, this message translates to:
  /// **'Medicine'**
  String get medicineText;

  /// No description provided for @educationText.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get educationText;

  /// No description provided for @othersText.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get othersText;

  /// No description provided for @overviewText.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewText;

  /// No description provided for @transactionText.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionText;

  /// No description provided for @settingsText.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsText;

  /// No description provided for @noNotesFoundText.
  ///
  /// In en, this message translates to:
  /// **'No notes found'**
  String get noNotesFoundText;

  /// No description provided for @editedLocally.
  ///
  /// In en, this message translates to:
  /// **'Edited Locally'**
  String get editedLocally;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ta': return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
