// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'Flutter履歴書';

  @override
  String get welcomeScreenDescription => '開発中...';

  @override
  String get splashAdTips => '偽のスプラッシュ広告';

  @override
  String get splashAdSkip => 'スキップ';

  @override
  String get loginInputAccountTips => 'アカウント';

  @override
  String get loginInputPasswordTips => 'パスワード';

  @override
  String get loginForgetPasswordButton => 'パスワードをお忘れですか?';

  @override
  String get loginConfirmButton => 'ログイン';

  @override
  String get loginRegisterButton => '登録する';

  @override
  String get loginDivider => 'または';

  @override
  String get homeBottomNavigationBarItemHome => 'ホーム';

  @override
  String get homeBottomNavigationBarItemSample => 'サンプル';

  @override
  String get homeBottomNavigationBarItemMessage => 'メッセージ';

  @override
  String get homeBottomNavigationBarItemProfile => '私';

  @override
  String get exitConfirmDialogTitle => 'プロンプト';

  @override
  String get exitConfirmDialogContent => 'アプリケーションを終了してもよろしいですか?';

  @override
  String get exitConfirmDialogNegativeButtonText => 'キャンセル';

  @override
  String get exitConfirmDialogPositiveButtonText => '終了を確認します';

  @override
  String get feedTabTrend => '人気';

  @override
  String get feedTabDiscover => '発見';

  @override
  String get footerNoMore => 'これ以上はありません';

  @override
  String postCommentsInTotal(Object length) {
    return '合計 $length コメント';
  }

  @override
  String get postExpandMoreReplies => 'さらに返信を展開します';

  @override
  String get postNoReplies => 'まだコメントはありません';

  @override
  String get profileTabTrend => 'タイムライン';

  @override
  String get profileTabCollection => 'コレクション';

  @override
  String get settingScreenTitle => '設定';

  @override
  String get settingLogoutButton => 'ログアウト';

  @override
  String get settingGroupTitleCommon => '共通';

  @override
  String get settingGroupTitleAccount => 'アカウント';

  @override
  String get settingOptionLanguage => '言語';

  @override
  String get settingOptionThemeColor => 'テーマカラー';

  @override
  String get settingOptionChangePassword => 'パスワードを変更';

  @override
  String get settingOptionDeleteAccount => 'アカウントをキャンセル';

  @override
  String get colorRed => '赤';

  @override
  String get colorOrange => 'オレンジ';

  @override
  String get colorYellow => '黄色';

  @override
  String get colorGreen => '緑';

  @override
  String get colorCyan => 'シアン';

  @override
  String get colorBlue => '青';

  @override
  String get colorPurple => '紫';

  @override
  String get imageLoadFailedHint => 'おっと...画像をロードできません';

  @override
  String get sampleAsyncScreenTitle => 'Async サンプル';

  @override
  String get blockUIShowcaseTitle => 'UI Runner Task で時間のかかる操作を\n実行する';

  @override
  String get blockUIShowcaseContent =>
      '[操作を実行する] ボタンをクリックし、\n進行状況インジケーターがフリーズする\nのを確認してください。';

  @override
  String get blockUIShowcaseButtonText => '操作を実行する';

  @override
  String get computeShowcaseTitle => '新しい Isolate で時間のかかる操作を\n実行する';

  @override
  String get computeShowcaseContent =>
      '[操作を実行する] ボタンをクリックしても\n進行状況インジケーターは影響を受けません。';

  @override
  String get computeShowcaseButtonText => '操作を実行する';

  @override
  String get ioTaskShowcaseTitle => 'I/O 操作';

  @override
  String get ioTaskShowcaseContent =>
      'I/O 操作は IO Runner Task で実行され、\nUI をブロックしません';

  @override
  String get ioTaskShowcaseButtonText => '操作を実行する';

  @override
  String get serialTaskShowcaseTitle => '複数の非同期タスクがブロックされて\n待機していることを示します';

  @override
  String get serialTaskShowcaseContent => '合計消費時間は、すべての非同期タスクの\n消費時間の合計に等しい';

  @override
  String get serialTaskShowcaseButtonText => '計算に時間がかかります';

  @override
  String get serialTaskShowcaseButtonText2 => '戻る';

  @override
  String get parallelTaskShowcaseTitle => '複数の非同期タスクの並列処理を示します';

  @override
  String get parallelTaskShowcaseContent => '合計の消費時間は最長の消費時間と同じです';

  @override
  String get parallelTaskShowcaseButtonText => '計算に時間がかかります';

  @override
  String get parallelTaskShowcaseButtonText2 => '戻る';

  @override
  String get sampleKeyScreenTitle => 'Key サンプル';

  @override
  String get swapStatelessShowcaseTitle => 'StatelessWidget 交換順序';

  @override
  String get swapStatelessShowcaseContent =>
      '2 つのカラー ブロックの順序は通常通り入れ\n替えることができます';

  @override
  String get swapStatelessShowcaseButtonText => '順序を入れ替える';

  @override
  String get swapStatefulWithoutKeyShowcaseTitle =>
      'StatefulWidget 交換順序 (Key なし)';

  @override
  String get swapStatefulWithoutKeyShowcaseContent =>
      'シリアル番号はウィジェット コンストラクター\nパラメーターから取得されます\n\n色は State のプロパティです\n\nシリアル番号は交換できますが、\n色は交換できません';

  @override
  String get swapStatefulWithKeyShowcaseTitle => 'StatefulWidget 交換順序 (Key)';

  @override
  String get swapStatefulWithKeyShowcaseContent =>
      'シリアル番号はウィジェット コンストラクター\nによって渡されたパラメーターから取得されます\n\n色は State のプロパティです\n\nシリアル番号と色は交換できます';

  @override
  String get swapStatefulShowcaseButtonText => '順序を入れ替える';

  @override
  String get globalKeyShowcaseTitle => 'GlobalKey';

  @override
  String get globalKeyShowcaseContent =>
      '新しいページで GlobalKey を介してこの\nウィジェットにアクセスします';

  @override
  String get globalKeyShowcaseButtonText => '新しいページにジャンプ';

  @override
  String get sampleGlobalKeyAccessScreenTitle => 'GlobalKey access';

  @override
  String get sampleGlobalKeyAccessScreenContent =>
      'GlobalKey を通じて前のページのターゲット\nウィジェットを検索し、\nそのスクリーンショットを撮り、\n画像の形式で表示します';

  @override
  String get sampleLifecycleScreenTitle => 'Lifecycle サンプル';

  @override
  String get lifecycleVisualizationShowcaseTitle => 'Lifecycle';

  @override
  String get lifecycleVisualizationShowcaseContent =>
      'State の Lifecycle 変化を\nデモンストレーションします';

  @override
  String get lifecycleVisualizationShowcaseSetButtonText => '設定';

  @override
  String get lifecycleVisualizationShowcaseUpdateButtonText => '更新';

  @override
  String get lifecycleVisualizationShowcaseDependButtonText => '依存';

  @override
  String get lifecycleVisualizationShowcaseSwapButtonText => 'スワップ';

  @override
  String get lifecycleVisualizationShowcaseRemoveButtonText => '削除';

  @override
  String get sampleAnimationScreenTitle => 'Animation サンプル';

  @override
  String get animationControllerShowcaseTitle => 'AnimationController';

  @override
  String get animationControllerShowcaseContent => 'ショーケース アニメーション コントロール';

  @override
  String get animationControllerShowcaseIdleHint => '🖌⭐️ アニメーションの観察を開始';

  @override
  String get implicitAnimationShowcaseTitle => 'Implicit Animation';

  @override
  String get implicitAnimationShowcaseContent => 'Implicit Animationを表示';

  @override
  String get implicitAnimationShowcaseRandomizeButtonText => 'ランダム化';

  @override
  String get implicitAnimationShowcaseSwitchButtonText => 'スイッチ';

  @override
  String get curveShowcaseTitle => '曲線';

  @override
  String get curveShowcaseContent => 'デモ アニメーション カーブ';

  @override
  String get heroShowcaseTitle => 'Hero';

  @override
  String get heroShowcaseContent => '共有要素のアニメーションを表示';

  @override
  String get heroShowcaseButtonText => '新しいページにジャンプ';

  @override
  String get sampleHeroAnimationScreenTitle => 'Hero Animation';

  @override
  String get staggeredAnimationShowcaseTitle => 'Staggered Animation';

  @override
  String get staggeredAnimationShowcaseContent =>
      '[0.0 - 1.0]: 変位\n[0.4 - 0.7]: 回転\n[0.0 - 0.5]: スケール';

  @override
  String get sampleRouterScreenTitle => 'Router Sample';
}
