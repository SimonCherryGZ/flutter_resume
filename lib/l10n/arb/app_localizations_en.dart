// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'FlutterResume';

  @override
  String get welcomeScreenDescription => 'Work in progress...';

  @override
  String get splashAdTips => 'Pretend this is an splash ad';

  @override
  String get splashAdSkip => 'Skip';

  @override
  String get loginInputAccountTips => 'Please enter user name';

  @override
  String get loginInputPasswordTips => 'Please enter password';

  @override
  String get loginForgetPasswordButton => 'Forgot password?';

  @override
  String get loginConfirmButton => 'Login';

  @override
  String get loginRegisterButton => 'Register';

  @override
  String get loginDivider => 'or';

  @override
  String get homeBottomNavigationBarItemHome => 'Home';

  @override
  String get homeBottomNavigationBarItemSample => 'Sample';

  @override
  String get homeBottomNavigationBarItemMessage => 'Message';

  @override
  String get homeBottomNavigationBarItemProfile => 'Profile';

  @override
  String get exitConfirmDialogTitle => 'Tips';

  @override
  String get exitConfirmDialogContent => 'Are you sure to exit?';

  @override
  String get exitConfirmDialogNegativeButtonText => 'Cancel';

  @override
  String get exitConfirmDialogPositiveButtonText => 'Confirm';

  @override
  String get feedTabTrend => 'Trend';

  @override
  String get feedTabDiscover => 'Discover';

  @override
  String get footerNoMore => 'No more';

  @override
  String postCommentsInTotal(Object length) {
    return '$length comments in total';
  }

  @override
  String get postExpandMoreReplies => 'Expand more replies';

  @override
  String get postNoReplies => 'No replies';

  @override
  String get profileTabTrend => 'Trend';

  @override
  String get profileTabCollection => 'Collection';

  @override
  String get settingScreenTitle => 'Setting';

  @override
  String get settingLogoutButton => 'Logout';

  @override
  String get settingGroupTitleCommon => 'Common';

  @override
  String get settingGroupTitleAccount => 'Account';

  @override
  String get settingOptionLanguage => 'Language';

  @override
  String get settingOptionThemeColor => 'Theme Color';

  @override
  String get settingOptionChangePassword => 'Change Password';

  @override
  String get settingOptionDeleteAccount => 'Delete Account';

  @override
  String get colorRed => 'Red';

  @override
  String get colorOrange => 'Orange';

  @override
  String get colorYellow => 'Yellow';

  @override
  String get colorGreen => 'Green';

  @override
  String get colorCyan => 'Cyan';

  @override
  String get colorBlue => 'Blue';

  @override
  String get colorPurple => 'Purple';

  @override
  String get imageLoadFailedHint => 'Oops...Image cannot be loaded';

  @override
  String get sampleAsyncScreenTitle => 'Async Sample';

  @override
  String get blockUIShowcaseTitle =>
      'Perform time-consuming\noperations in UI Task Runner';

  @override
  String get blockUIShowcaseContent =>
      'Click the【Perform operation】button\nand watch the progress indicator freeze';

  @override
  String get blockUIShowcaseButtonText => 'Perform operation';

  @override
  String get computeShowcaseTitle =>
      'Perform time-consuming\noperations in a new isolate';

  @override
  String get computeShowcaseContent =>
      'Click the【Perform operation】button\nand see that the progress indicator\nis not affected';

  @override
  String get computeShowcaseButtonText => 'Perform operation';

  @override
  String get ioTaskShowcaseTitle => 'I/O operations';

  @override
  String get ioTaskShowcaseContent =>
      'I/O operations are performed in the\nIO Task Runner and do not block the UI';

  @override
  String get ioTaskShowcaseButtonText => 'Perform operation';

  @override
  String get serialTaskShowcaseTitle =>
      'Demonstrating multiple asynchronous\ntasks blocking and waiting';

  @override
  String get serialTaskShowcaseContent =>
      'The total time consumption is equal to the sum of\nthe time consumption of all asynchronous tasks';

  @override
  String get serialTaskShowcaseButtonText => 'Calculate time cost';

  @override
  String get serialTaskShowcaseButtonText2 => 'Return';

  @override
  String get parallelTaskShowcaseTitle =>
      'Demonstrating multiple asynchronous\ntasks running in parallel';

  @override
  String get parallelTaskShowcaseContent =>
      'The total time consumption is equal to the largest\ntime consumption among them';

  @override
  String get parallelTaskShowcaseButtonText => 'Calculate time cost';

  @override
  String get parallelTaskShowcaseButtonText2 => 'Return';

  @override
  String get sampleKeyScreenTitle => 'Key Sample';

  @override
  String get swapStatelessShowcaseTitle => 'StatelessWidget exchange order';

  @override
  String get swapStatelessShowcaseContent =>
      'The order of two color blocks can be\nswapped normally';

  @override
  String get swapStatelessShowcaseButtonText => 'Exchange order';

  @override
  String get swapStatefulWithoutKeyShowcaseTitle =>
      'StatefulWidget exchange order\n(without key)';

  @override
  String get swapStatefulWithoutKeyShowcaseContent =>
      'The index comes from the parameters\npassed by the Widget constructor\n\nColor is a property in State\n\nIndex can be exchanged, but colors cannot';

  @override
  String get swapStatefulWithKeyShowcaseTitle =>
      'StatefulWidget exchange order\n(with key)';

  @override
  String get swapStatefulWithKeyShowcaseContent =>
      'The index comes from the parameters\npassed by the Widget constructor\n\nColor is a property in State\n\nBoth index and colors can be exchanged';

  @override
  String get swapStatefulShowcaseButtonText => 'Exchange order';

  @override
  String get globalKeyShowcaseTitle => 'GlobalKey';

  @override
  String get globalKeyShowcaseContent =>
      'Access this Widget via GlobalKey on a new page';

  @override
  String get globalKeyShowcaseButtonText => 'Jump to new page';

  @override
  String get sampleGlobalKeyAccessScreenTitle => 'GlobalKey access';

  @override
  String get sampleGlobalKeyAccessScreenContent =>
      'Find the target Widget of the previous page\nthrough GlobalKey, then take a screenshot of\nit and display it in the form of Image';

  @override
  String get sampleLifecycleScreenTitle => 'Lifecycle Sample';

  @override
  String get lifecycleVisualizationShowcaseTitle => 'Lifecycle';

  @override
  String get lifecycleVisualizationShowcaseContent =>
      'Demonstrate the life cycle changes of State';

  @override
  String get lifecycleVisualizationShowcaseSetButtonText => 'Set';

  @override
  String get lifecycleVisualizationShowcaseUpdateButtonText => 'Update';

  @override
  String get lifecycleVisualizationShowcaseDependButtonText => 'Depend';

  @override
  String get lifecycleVisualizationShowcaseSwapButtonText => 'Swap';

  @override
  String get lifecycleVisualizationShowcaseRemoveButtonText => 'Remove';

  @override
  String get sampleAnimationScreenTitle => 'Animation Sample';

  @override
  String get animationControllerShowcaseTitle => 'Animation Controller';

  @override
  String get animationControllerShowcaseContent =>
      'Demonstrate animation control logic';

  @override
  String get animationControllerShowcaseIdleHint =>
      'Start to watch 🖌⭐️ animation';

  @override
  String get implicitAnimationShowcaseTitle => 'Implicit Animation';

  @override
  String get implicitAnimationShowcaseContent =>
      'Demonstrate implicit animation';

  @override
  String get implicitAnimationShowcaseRandomizeButtonText => 'Randomize';

  @override
  String get implicitAnimationShowcaseSwitchButtonText => 'Switch';

  @override
  String get curveShowcaseTitle => 'Curve';

  @override
  String get curveShowcaseContent => 'Demonstrate Curve';

  @override
  String get heroShowcaseTitle => 'Hero';

  @override
  String get heroShowcaseContent => 'Demonstrate shared element animation';

  @override
  String get heroShowcaseButtonText => 'Jump to new page';

  @override
  String get sampleHeroAnimationScreenTitle => 'Hero animation';

  @override
  String get staggeredAnimationShowcaseTitle => 'Staggered Animation';

  @override
  String get staggeredAnimationShowcaseContent =>
      'Demonstrate staggered animation\n【0.0 - 1.0】: translation\n【0.4 - 0.7】: rotation\n【0.0 - 0.5】: scale';

  @override
  String get sampleRouterScreenTitle => 'Router Sample';
}
