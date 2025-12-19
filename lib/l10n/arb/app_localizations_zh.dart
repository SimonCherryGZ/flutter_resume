// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Flutter简历';

  @override
  String get welcomeScreenDescription => '开发中...';

  @override
  String get splashAdTips => '假装这是开屏广告';

  @override
  String get splashAdSkip => '跳过';

  @override
  String get loginInputAccountTips => '请输入用户名';

  @override
  String get loginInputPasswordTips => '请输入密码';

  @override
  String get loginForgetPasswordButton => '忘记密码？';

  @override
  String get loginConfirmButton => '登录';

  @override
  String get loginRegisterButton => '注册新账号';

  @override
  String get loginDivider => '或';

  @override
  String get homeBottomNavigationBarItemHome => '首页';

  @override
  String get homeBottomNavigationBarItemSample => '示例';

  @override
  String get homeBottomNavigationBarItemMessage => '消息';

  @override
  String get homeBottomNavigationBarItemProfile => '我的';

  @override
  String get exitConfirmDialogTitle => '提示';

  @override
  String get exitConfirmDialogContent => '确定要退出应用吗?';

  @override
  String get exitConfirmDialogNegativeButtonText => '取消';

  @override
  String get exitConfirmDialogPositiveButtonText => '确认退出';

  @override
  String get feedTabTrend => '热门';

  @override
  String get feedTabDiscover => '发现';

  @override
  String get footerNoMore => '没有更多了';

  @override
  String postCommentsInTotal(Object length) {
    return '共 $length 条评论';
  }

  @override
  String get postExpandMoreReplies => '展开更多回复';

  @override
  String get postNoReplies => '暂无评论';

  @override
  String get profileTabTrend => '动态';

  @override
  String get profileTabCollection => '收藏';

  @override
  String get settingScreenTitle => '设置';

  @override
  String get settingLogoutButton => '退出登录';

  @override
  String get settingGroupTitleCommon => '通用';

  @override
  String get settingGroupTitleAccount => '账号';

  @override
  String get settingOptionLanguage => '语言';

  @override
  String get settingOptionThemeColor => '主题色';

  @override
  String get settingOptionChangePassword => '修改密码';

  @override
  String get settingOptionDeleteAccount => '注销账号';

  @override
  String get colorRed => '红色';

  @override
  String get colorOrange => '橙色';

  @override
  String get colorYellow => '黄色';

  @override
  String get colorGreen => '绿色';

  @override
  String get colorCyan => '青色';

  @override
  String get colorBlue => '蓝色';

  @override
  String get colorPurple => '紫色';

  @override
  String get imageLoadFailedHint => 'Oops...图片无法加载';

  @override
  String get sampleAsyncScreenTitle => 'Async 示例';

  @override
  String get blockUIShowcaseTitle => 'UI Task Runner 中执行耗时操作';

  @override
  String get blockUIShowcaseContent => '点击【执行耗时操作】按钮，观察进度指示器卡顿';

  @override
  String get blockUIShowcaseButtonText => '执行耗时操作';

  @override
  String get computeShowcaseTitle => '新 Isolate 中执行耗时操作';

  @override
  String get computeShowcaseContent => '点击【执行耗时操作】按钮，进度指示器不受影响';

  @override
  String get computeShowcaseButtonText => '执行耗时操作';

  @override
  String get ioTaskShowcaseTitle => 'I/O 操作';

  @override
  String get ioTaskShowcaseContent => 'I/O 操作在 IO Task Runner 中执行，不阻塞 UI';

  @override
  String get ioTaskShowcaseButtonText => '执行 I/O 操作';

  @override
  String get serialTaskShowcaseTitle => '演示多个异步任务阻塞等待';

  @override
  String get serialTaskShowcaseContent => '总耗时等于全部异步任务耗时的总和';

  @override
  String get serialTaskShowcaseButtonText => '计算耗时';

  @override
  String get serialTaskShowcaseButtonText2 => '返回';

  @override
  String get parallelTaskShowcaseTitle => '演示多个异步任务并行处理';

  @override
  String get parallelTaskShowcaseContent => '总耗时等于最长的耗时';

  @override
  String get parallelTaskShowcaseButtonText => '计算耗时';

  @override
  String get parallelTaskShowcaseButtonText2 => '返回';

  @override
  String get sampleKeyScreenTitle => 'Key 示例';

  @override
  String get swapStatelessShowcaseTitle => 'StatelessWidget 交换顺序';

  @override
  String get swapStatelessShowcaseContent => '两个颜色块可正常交换顺序';

  @override
  String get swapStatelessShowcaseButtonText => '交换顺序';

  @override
  String get swapStatefulWithoutKeyShowcaseTitle =>
      'StatefulWidget 交换顺序（无 Key）';

  @override
  String get swapStatefulWithoutKeyShowcaseContent =>
      '序号来自 Widget 构造器传参\n颜色是 State 中的属性\n序号能交换，但颜色无法交换';

  @override
  String get swapStatefulWithKeyShowcaseTitle => 'StatefulWidget 交换顺序（有 Key）';

  @override
  String get swapStatefulWithKeyShowcaseContent =>
      '序号来自 Widget 构造器传参\n颜色是 State 中的属性\n序号和颜色都能交换';

  @override
  String get swapStatefulShowcaseButtonText => '交换顺序';

  @override
  String get globalKeyShowcaseTitle => 'GlobalKey';

  @override
  String get globalKeyShowcaseContent => '在新页面通过 GlobalKey 访问此 Widget';

  @override
  String get globalKeyShowcaseButtonText => '跳转新页面';

  @override
  String get sampleGlobalKeyAccessScreenTitle => 'GlobalKey 访问';

  @override
  String get sampleGlobalKeyAccessScreenContent =>
      '通过 GlobalKey 找到上一个页面的目标 Widget\n然后对其截屏，以 Image 形式显示';

  @override
  String get sampleLifecycleScreenTitle => 'Lifecycle 示例';

  @override
  String get lifecycleVisualizationShowcaseTitle => 'Lifecycle';

  @override
  String get lifecycleVisualizationShowcaseContent => '演示 State 的生命周期变化';

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
  String get sampleAnimationScreenTitle => 'Animation 示例';

  @override
  String get animationControllerShowcaseTitle => 'Animation Controller';

  @override
  String get animationControllerShowcaseContent => '演示动画控制';

  @override
  String get animationControllerShowcaseIdleHint => '启动观察 🖌⭐️ 动画';

  @override
  String get implicitAnimationShowcaseTitle => 'Implicit Animation';

  @override
  String get implicitAnimationShowcaseContent => '演示隐式动画';

  @override
  String get implicitAnimationShowcaseRandomizeButtonText => '随机化';

  @override
  String get implicitAnimationShowcaseSwitchButtonText => '切换';

  @override
  String get curveShowcaseTitle => 'Curve';

  @override
  String get curveShowcaseContent => '演示动画曲线';

  @override
  String get heroShowcaseTitle => 'Hero';

  @override
  String get heroShowcaseContent => '演示共享元素动画';

  @override
  String get heroShowcaseButtonText => '跳转新页面';

  @override
  String get sampleHeroAnimationScreenTitle => 'Hero 动画';

  @override
  String get staggeredAnimationShowcaseTitle => '交织动画（Staggered Animation）';

  @override
  String get staggeredAnimationShowcaseContent =>
      '演示交织动画\n【0.0 - 1.0】: 位移\n【0.4 - 0.7】: 旋转\n【0.0 - 0.5】: 缩放';

  @override
  String get sampleRouterScreenTitle => 'Router Sample';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appName => 'Flutter簡歷';

  @override
  String get welcomeScreenDescription => '開發中...';

  @override
  String get splashAdTips => '假裝這是開屏廣告';

  @override
  String get splashAdSkip => '跳過';

  @override
  String get loginInputAccountTips => '請輸入用戶名';

  @override
  String get loginInputPasswordTips => '請輸入密碼';

  @override
  String get loginForgetPasswordButton => '忘記密碼？';

  @override
  String get loginConfirmButton => '登錄';

  @override
  String get loginRegisterButton => '註冊新賬號';

  @override
  String get loginDivider => '或';

  @override
  String get homeBottomNavigationBarItemHome => '首頁';

  @override
  String get homeBottomNavigationBarItemSample => '示例';

  @override
  String get homeBottomNavigationBarItemMessage => '消息';

  @override
  String get homeBottomNavigationBarItemProfile => '我的';

  @override
  String get exitConfirmDialogTitle => '提示';

  @override
  String get exitConfirmDialogContent => '確定要退出應用嗎?';

  @override
  String get exitConfirmDialogNegativeButtonText => '取消';

  @override
  String get exitConfirmDialogPositiveButtonText => '確認退出';

  @override
  String get feedTabTrend => '熱門';

  @override
  String get feedTabDiscover => '發現';

  @override
  String get footerNoMore => '沒有更多了';

  @override
  String postCommentsInTotal(Object length) {
    return '共 $length 條評論';
  }

  @override
  String get postExpandMoreReplies => '展開更多回復';

  @override
  String get postNoReplies => '暫無評論';

  @override
  String get profileTabTrend => '動態';

  @override
  String get profileTabCollection => '收藏';

  @override
  String get settingScreenTitle => '設置';

  @override
  String get settingLogoutButton => '退出登錄';

  @override
  String get settingGroupTitleCommon => '通用';

  @override
  String get settingGroupTitleAccount => '賬號';

  @override
  String get settingOptionLanguage => '語言';

  @override
  String get settingOptionThemeColor => '主題色';

  @override
  String get settingOptionChangePassword => '修改密碼';

  @override
  String get settingOptionDeleteAccount => '註銷賬號';

  @override
  String get colorRed => '紅色';

  @override
  String get colorOrange => '橙色';

  @override
  String get colorYellow => '黃色';

  @override
  String get colorGreen => '綠色';

  @override
  String get colorCyan => '青色';

  @override
  String get colorBlue => '藍色';

  @override
  String get colorPurple => '紫色';

  @override
  String get imageLoadFailedHint => 'Oops...圖片無法加載';

  @override
  String get sampleAsyncScreenTitle => 'Async 示例';

  @override
  String get blockUIShowcaseTitle => 'UI Task Runner 中執行耗時操作';

  @override
  String get blockUIShowcaseContent => '點擊【執行耗時操作】按鈕，觀察進度指示器卡頓';

  @override
  String get blockUIShowcaseButtonText => '執行耗時操作';

  @override
  String get computeShowcaseTitle => '新 Isolate 中執行耗時操作';

  @override
  String get computeShowcaseContent => '點擊【執行耗時操作】按鈕，進度指示器不受影響';

  @override
  String get computeShowcaseButtonText => '執行耗時操作';

  @override
  String get ioTaskShowcaseTitle => 'I/O 操作';

  @override
  String get ioTaskShowcaseContent => 'I/O 操作在 IO Task Runner 中執行，不阻塞 UI';

  @override
  String get ioTaskShowcaseButtonText => '執行 I/O 操作';

  @override
  String get serialTaskShowcaseTitle => '演示多個異步任務阻塞等待';

  @override
  String get serialTaskShowcaseContent => '總耗時等於全部異步任務耗時的總和';

  @override
  String get serialTaskShowcaseButtonText => '計算耗時';

  @override
  String get serialTaskShowcaseButtonText2 => '返回';

  @override
  String get parallelTaskShowcaseTitle => '演示多個異步任務並行處理';

  @override
  String get parallelTaskShowcaseContent => '總耗時等於最長的耗時';

  @override
  String get parallelTaskShowcaseButtonText => '計算耗時';

  @override
  String get parallelTaskShowcaseButtonText2 => '返回';

  @override
  String get sampleKeyScreenTitle => 'Key 示例';

  @override
  String get swapStatelessShowcaseTitle => 'StatelessWidget 交換順序';

  @override
  String get swapStatelessShowcaseContent => '兩個顏色塊可正常交換順序';

  @override
  String get swapStatelessShowcaseButtonText => '交換順序';

  @override
  String get swapStatefulWithoutKeyShowcaseTitle =>
      'StatefulWidget 交換順序（無 Key）';

  @override
  String get swapStatefulWithoutKeyShowcaseContent =>
      '序號來自 Widget 構造器傳參\n顏色是 State 中的屬性\n序號能交換，但顏色無法交換';

  @override
  String get swapStatefulWithKeyShowcaseTitle => 'StatefulWidget 交換順序（有 Key）';

  @override
  String get swapStatefulWithKeyShowcaseContent =>
      '序號來自 Widget 構造器傳參\n顏色是 State 中的屬性\n序號和顏色都能交換';

  @override
  String get swapStatefulShowcaseButtonText => '交換順序';

  @override
  String get globalKeyShowcaseTitle => 'GlobalKey';

  @override
  String get globalKeyShowcaseContent => '在新頁面通過 GlobalKey 訪問此 Widget';

  @override
  String get globalKeyShowcaseButtonText => '跳轉新頁面';

  @override
  String get sampleGlobalKeyAccessScreenTitle => 'GlobalKey 訪問';

  @override
  String get sampleGlobalKeyAccessScreenContent =>
      '通過 GlobalKey 找到上一個頁面的目標 Widget\n然後對其截屏，以 Image 形式顯示';

  @override
  String get sampleLifecycleScreenTitle => 'Lifecycle 示例';

  @override
  String get lifecycleVisualizationShowcaseTitle => 'Lifecycle';

  @override
  String get lifecycleVisualizationShowcaseContent => '演示 State 的生命周期變化';

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
  String get sampleAnimationScreenTitle => 'Animation 示例';

  @override
  String get animationControllerShowcaseTitle => 'Animation Controller';

  @override
  String get animationControllerShowcaseContent => '演示動畫控製';

  @override
  String get animationControllerShowcaseIdleHint => '啟動觀察 🖌⭐️ 動畫';

  @override
  String get implicitAnimationShowcaseTitle => 'Implicit Animation';

  @override
  String get implicitAnimationShowcaseContent => '演示隱式動畫';

  @override
  String get implicitAnimationShowcaseRandomizeButtonText => '隨機化';

  @override
  String get implicitAnimationShowcaseSwitchButtonText => '切換';

  @override
  String get curveShowcaseTitle => 'Curve';

  @override
  String get curveShowcaseContent => '演示動畫曲線';

  @override
  String get heroShowcaseTitle => 'Hero';

  @override
  String get heroShowcaseContent => '演示共享元素動畫';

  @override
  String get heroShowcaseButtonText => '跳轉新頁面';

  @override
  String get sampleHeroAnimationScreenTitle => 'Hero 動畫';

  @override
  String get staggeredAnimationShowcaseTitle => '交織動畫（Staggered Animation）';

  @override
  String get staggeredAnimationShowcaseContent =>
      '演示交織動畫\n【0.0 - 1.0】: 位移\n【0.4 - 0.7】: 旋轉\n【0.0 - 0.5】: 縮放';
}
