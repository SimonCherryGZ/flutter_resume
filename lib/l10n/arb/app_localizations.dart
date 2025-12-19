import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'FlutterResume'**
  String get appName;

  /// No description provided for @welcomeScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Work in progress...'**
  String get welcomeScreenDescription;

  /// No description provided for @splashAdTips.
  ///
  /// In en, this message translates to:
  /// **'Pretend this is an splash ad'**
  String get splashAdTips;

  /// No description provided for @splashAdSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get splashAdSkip;

  /// No description provided for @loginInputAccountTips.
  ///
  /// In en, this message translates to:
  /// **'Please enter user name'**
  String get loginInputAccountTips;

  /// No description provided for @loginInputPasswordTips.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get loginInputPasswordTips;

  /// No description provided for @loginForgetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgetPasswordButton;

  /// No description provided for @loginConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginConfirmButton;

  /// No description provided for @loginRegisterButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get loginRegisterButton;

  /// No description provided for @loginDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get loginDivider;

  /// No description provided for @homeBottomNavigationBarItemHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeBottomNavigationBarItemHome;

  /// No description provided for @homeBottomNavigationBarItemSample.
  ///
  /// In en, this message translates to:
  /// **'Sample'**
  String get homeBottomNavigationBarItemSample;

  /// No description provided for @homeBottomNavigationBarItemMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get homeBottomNavigationBarItemMessage;

  /// No description provided for @homeBottomNavigationBarItemProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get homeBottomNavigationBarItemProfile;

  /// No description provided for @exitConfirmDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get exitConfirmDialogTitle;

  /// No description provided for @exitConfirmDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to exit?'**
  String get exitConfirmDialogContent;

  /// No description provided for @exitConfirmDialogNegativeButtonText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get exitConfirmDialogNegativeButtonText;

  /// No description provided for @exitConfirmDialogPositiveButtonText.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get exitConfirmDialogPositiveButtonText;

  /// No description provided for @feedTabTrend.
  ///
  /// In en, this message translates to:
  /// **'Trend'**
  String get feedTabTrend;

  /// No description provided for @feedTabDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get feedTabDiscover;

  /// No description provided for @footerNoMore.
  ///
  /// In en, this message translates to:
  /// **'No more'**
  String get footerNoMore;

  /// No description provided for @postCommentsInTotal.
  ///
  /// In en, this message translates to:
  /// **'{length} comments in total'**
  String postCommentsInTotal(Object length);

  /// No description provided for @postExpandMoreReplies.
  ///
  /// In en, this message translates to:
  /// **'Expand more replies'**
  String get postExpandMoreReplies;

  /// No description provided for @postNoReplies.
  ///
  /// In en, this message translates to:
  /// **'No replies'**
  String get postNoReplies;

  /// No description provided for @profileTabTrend.
  ///
  /// In en, this message translates to:
  /// **'Trend'**
  String get profileTabTrend;

  /// No description provided for @profileTabCollection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get profileTabCollection;

  /// No description provided for @settingScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get settingScreenTitle;

  /// No description provided for @settingLogoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingLogoutButton;

  /// No description provided for @settingGroupTitleCommon.
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get settingGroupTitleCommon;

  /// No description provided for @settingGroupTitleAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingGroupTitleAccount;

  /// No description provided for @settingOptionLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingOptionLanguage;

  /// No description provided for @settingOptionThemeColor.
  ///
  /// In en, this message translates to:
  /// **'Theme Color'**
  String get settingOptionThemeColor;

  /// No description provided for @settingOptionChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get settingOptionChangePassword;

  /// No description provided for @settingOptionDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingOptionDeleteAccount;

  /// No description provided for @colorRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get colorRed;

  /// No description provided for @colorOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get colorOrange;

  /// No description provided for @colorYellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get colorYellow;

  /// No description provided for @colorGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get colorGreen;

  /// No description provided for @colorCyan.
  ///
  /// In en, this message translates to:
  /// **'Cyan'**
  String get colorCyan;

  /// No description provided for @colorBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get colorBlue;

  /// No description provided for @colorPurple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get colorPurple;

  /// No description provided for @imageLoadFailedHint.
  ///
  /// In en, this message translates to:
  /// **'Oops...Image cannot be loaded'**
  String get imageLoadFailedHint;

  /// No description provided for @sampleAsyncScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Async Sample'**
  String get sampleAsyncScreenTitle;

  /// No description provided for @blockUIShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Perform time-consuming\noperations in UI Task Runner'**
  String get blockUIShowcaseTitle;

  /// No description provided for @blockUIShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Click the【Perform operation】button\nand watch the progress indicator freeze'**
  String get blockUIShowcaseContent;

  /// No description provided for @blockUIShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Perform operation'**
  String get blockUIShowcaseButtonText;

  /// No description provided for @computeShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Perform time-consuming\noperations in a new isolate'**
  String get computeShowcaseTitle;

  /// No description provided for @computeShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Click the【Perform operation】button\nand see that the progress indicator\nis not affected'**
  String get computeShowcaseContent;

  /// No description provided for @computeShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Perform operation'**
  String get computeShowcaseButtonText;

  /// No description provided for @ioTaskShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'I/O operations'**
  String get ioTaskShowcaseTitle;

  /// No description provided for @ioTaskShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'I/O operations are performed in the\nIO Task Runner and do not block the UI'**
  String get ioTaskShowcaseContent;

  /// No description provided for @ioTaskShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Perform operation'**
  String get ioTaskShowcaseButtonText;

  /// No description provided for @serialTaskShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Demonstrating multiple asynchronous\ntasks blocking and waiting'**
  String get serialTaskShowcaseTitle;

  /// No description provided for @serialTaskShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'The total time consumption is equal to the sum of\nthe time consumption of all asynchronous tasks'**
  String get serialTaskShowcaseContent;

  /// No description provided for @serialTaskShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Calculate time cost'**
  String get serialTaskShowcaseButtonText;

  /// No description provided for @serialTaskShowcaseButtonText2.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get serialTaskShowcaseButtonText2;

  /// No description provided for @parallelTaskShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Demonstrating multiple asynchronous\ntasks running in parallel'**
  String get parallelTaskShowcaseTitle;

  /// No description provided for @parallelTaskShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'The total time consumption is equal to the largest\ntime consumption among them'**
  String get parallelTaskShowcaseContent;

  /// No description provided for @parallelTaskShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Calculate time cost'**
  String get parallelTaskShowcaseButtonText;

  /// No description provided for @parallelTaskShowcaseButtonText2.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get parallelTaskShowcaseButtonText2;

  /// No description provided for @sampleKeyScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Key Sample'**
  String get sampleKeyScreenTitle;

  /// No description provided for @swapStatelessShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'StatelessWidget exchange order'**
  String get swapStatelessShowcaseTitle;

  /// No description provided for @swapStatelessShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'The order of two color blocks can be\nswapped normally'**
  String get swapStatelessShowcaseContent;

  /// No description provided for @swapStatelessShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Exchange order'**
  String get swapStatelessShowcaseButtonText;

  /// No description provided for @swapStatefulWithoutKeyShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'StatefulWidget exchange order\n(without key)'**
  String get swapStatefulWithoutKeyShowcaseTitle;

  /// No description provided for @swapStatefulWithoutKeyShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'The index comes from the parameters\npassed by the Widget constructor\n\nColor is a property in State\n\nIndex can be exchanged, but colors cannot'**
  String get swapStatefulWithoutKeyShowcaseContent;

  /// No description provided for @swapStatefulWithKeyShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'StatefulWidget exchange order\n(with key)'**
  String get swapStatefulWithKeyShowcaseTitle;

  /// No description provided for @swapStatefulWithKeyShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'The index comes from the parameters\npassed by the Widget constructor\n\nColor is a property in State\n\nBoth index and colors can be exchanged'**
  String get swapStatefulWithKeyShowcaseContent;

  /// No description provided for @swapStatefulShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Exchange order'**
  String get swapStatefulShowcaseButtonText;

  /// No description provided for @globalKeyShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'GlobalKey'**
  String get globalKeyShowcaseTitle;

  /// No description provided for @globalKeyShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Access this Widget via GlobalKey on a new page'**
  String get globalKeyShowcaseContent;

  /// No description provided for @globalKeyShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Jump to new page'**
  String get globalKeyShowcaseButtonText;

  /// No description provided for @sampleGlobalKeyAccessScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'GlobalKey access'**
  String get sampleGlobalKeyAccessScreenTitle;

  /// No description provided for @sampleGlobalKeyAccessScreenContent.
  ///
  /// In en, this message translates to:
  /// **'Find the target Widget of the previous page\nthrough GlobalKey, then take a screenshot of\nit and display it in the form of Image'**
  String get sampleGlobalKeyAccessScreenContent;

  /// No description provided for @sampleLifecycleScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Lifecycle Sample'**
  String get sampleLifecycleScreenTitle;

  /// No description provided for @lifecycleVisualizationShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Lifecycle'**
  String get lifecycleVisualizationShowcaseTitle;

  /// No description provided for @lifecycleVisualizationShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Demonstrate the life cycle changes of State'**
  String get lifecycleVisualizationShowcaseContent;

  /// No description provided for @lifecycleVisualizationShowcaseSetButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get lifecycleVisualizationShowcaseSetButtonText;

  /// No description provided for @lifecycleVisualizationShowcaseUpdateButtonText.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get lifecycleVisualizationShowcaseUpdateButtonText;

  /// No description provided for @lifecycleVisualizationShowcaseDependButtonText.
  ///
  /// In en, this message translates to:
  /// **'Depend'**
  String get lifecycleVisualizationShowcaseDependButtonText;

  /// No description provided for @lifecycleVisualizationShowcaseSwapButtonText.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get lifecycleVisualizationShowcaseSwapButtonText;

  /// No description provided for @lifecycleVisualizationShowcaseRemoveButtonText.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get lifecycleVisualizationShowcaseRemoveButtonText;

  /// No description provided for @sampleAnimationScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Animation Sample'**
  String get sampleAnimationScreenTitle;

  /// No description provided for @animationControllerShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Animation Controller'**
  String get animationControllerShowcaseTitle;

  /// No description provided for @animationControllerShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Demonstrate animation control logic'**
  String get animationControllerShowcaseContent;

  /// No description provided for @animationControllerShowcaseIdleHint.
  ///
  /// In en, this message translates to:
  /// **'Start to watch 🖌⭐️ animation'**
  String get animationControllerShowcaseIdleHint;

  /// No description provided for @implicitAnimationShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Implicit Animation'**
  String get implicitAnimationShowcaseTitle;

  /// No description provided for @implicitAnimationShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Demonstrate implicit animation'**
  String get implicitAnimationShowcaseContent;

  /// No description provided for @implicitAnimationShowcaseRandomizeButtonText.
  ///
  /// In en, this message translates to:
  /// **'Randomize'**
  String get implicitAnimationShowcaseRandomizeButtonText;

  /// No description provided for @implicitAnimationShowcaseSwitchButtonText.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get implicitAnimationShowcaseSwitchButtonText;

  /// No description provided for @curveShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Curve'**
  String get curveShowcaseTitle;

  /// No description provided for @curveShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Demonstrate Curve'**
  String get curveShowcaseContent;

  /// No description provided for @heroShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Hero'**
  String get heroShowcaseTitle;

  /// No description provided for @heroShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Demonstrate shared element animation'**
  String get heroShowcaseContent;

  /// No description provided for @heroShowcaseButtonText.
  ///
  /// In en, this message translates to:
  /// **'Jump to new page'**
  String get heroShowcaseButtonText;

  /// No description provided for @sampleHeroAnimationScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Hero animation'**
  String get sampleHeroAnimationScreenTitle;

  /// No description provided for @staggeredAnimationShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Staggered Animation'**
  String get staggeredAnimationShowcaseTitle;

  /// No description provided for @staggeredAnimationShowcaseContent.
  ///
  /// In en, this message translates to:
  /// **'Demonstrate staggered animation\n【0.0 - 1.0】: translation\n【0.4 - 0.7】: rotation\n【0.0 - 0.5】: scale'**
  String get staggeredAnimationShowcaseContent;

  /// No description provided for @sampleRouterScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Router Sample'**
  String get sampleRouterScreenTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
