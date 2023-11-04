<!-- TOC start (generated with https://github.com/derlin/bitdowntoc) -->

- [项目结构](#structure)
- [框架选型](#framework)
   * [状态管理](#state_management)
   * [路由管理](#router)
   * [国际化](#intl)
- [页面展示](#pages)
   * [启动页 & 登录页](#welcome)
   * [主页 - Feed 流](#feed)
   * [Feed 流详情](#feed_detail)
   * [个人主页](#profile)
   * [设置页](#setting)
   * [消息页](#message)
   * [贴纸功能](#sticker)
   * [Flutter 知识点可视化](#visualization)
      + [异步](#async)
      + [Key](#key)
      + [Lifecycle](#lifecycle)
      + [Animation](#animation)

<!-- TOC end -->

<!-- TOC --><a name="structure"></a>
# 项目结构

<img width="200" alt="project_structure" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/project_structure.png">

* config：项目配置、路由配置、常量等
* domain：Entity 类和 Repository 抽象类
* data：Repository 实现类（如有 DataSource 类也放这里）
* presentation：表现层代码
* l10n：国际化相关的代码和 arb 文件
* utils：工具类
表现层按模块划分

<img width="200" alt="presentation_structure" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/presentation_structure.png">

* bloc：flutter_bloc 相关代码
* view：页面类
* widget：控件类
<!-- TOC --><a name="framework"></a>
# 框架选型

<!-- TOC --><a name="state_management"></a>
## 状态管理

状态管理从 provider、flutter_bloc、redux、getx 中选择，最后选用 flutter_bloc。理由如下：

* provider：本质是对 InheritedWidget 的封装。Provider 本身没有数据刷新的能力，需要使用 Provider 的各种子类实现如 ListenableProvider、StreamProvider 等来监听数据变化并刷新依赖项，这就要求数据要包装成 Listenable、Stream 等。
* flutter_bloc：相当于 provider + bloc；bloc 是对 StreamController 的封装；利用 provider 让 bloc 有了更新依赖项的能力；在继承了 provider 的优点的基础上，提供了 BlocListener、BlocBuilder、BlocSelector 等便利的 Widget。
* redux：
    * UI 层如果想根据 Store 的变化，来显示 Loading、Toast 等，则只能放 build 方法中（用 flutter_bloc 类推，redux 只有 “BlocBuilder”（StoreConnector），没有“BlocListener”）；
    * StoreConnector 的 ignoreChange 只给了当前状态，无法做新旧差异对比；
    * 页面复用问题。redux 里的 State 是全局的，如果想给当前用户和其它用户共用“个人中心页”，则在页面跳转前后需要对全局 State 里的用户数据做切换。
* getx：代码量太大，短时间内无法掌握其原理，使用中如果出现问题，怕难以定位。
<!-- TOC --><a name="router"></a>
## 路由管理

路由管理用的是 go_router，它基于 Navigator 2.0。2.0 相比 1.0 主要是为了解决：

* 替换路由历史栈（如点击通知发起 intent）
* 声明式 API
* 嵌套路由
* Web 端地址栏 Url 同步页面变化
其它基于 2.0 的比较流行的库还有 auto_route、beamer 等。感觉和 go_router 所支持的特性差别不大；auto_route 是通过注解生成路由代码，beamer 有一些自己的概念需要去理解（BeamLocation、BeamState）；在特性支持差别不大的情况下，暂时先选择相对简洁的 go_router。

目前 Demo 中有实际利用到的 go_router 特性是路由重定向：

```dart
GoRoute(
  path: home,
  pageBuilder: (context, state) => buildSlideTransition(
    key: state.pageKey,
    child: const HomeScreen(),
  ),
  redirect: (context, state) async {
    final isSignedIn = context.read<AppCubit>().state.isSignedIn;
    if (!isSignedIn) {
      return login;
    }
    return null;
  },
),
```
在“主页”的路由中配置重定向逻辑，如果发现用户未登录，则重定向到“登录页”的路由。这样凡是涉及“跳转到主页”的代码，就不用重复写登录状态的判断。
<!-- TOC --><a name="intl"></a>
## 国际化

国际化用的是 Flutter 官方文档介绍的 intl 库。实际运用下来它有这些优点：

* arb 文件：与代码隔离，便于提取给翻译人员。对 arb 文件的修改也可以 Hot Reload。
* 对缺失语言的兼容：例如设置模板语言为英文，则其它支持语言缺少的文案条目，可以 fallback 到英文版本。
* 占位符（不同语言的语序差异）
中文 arb：

```dart
"postCommentsInTotal": "共 {length} 条评论",
```
英文 arb：
```dart
"postCommentsInTotal": "{length} comments in total",
```
它会生成如下代码，中文：
```dart
@override
String postCommentsInTotal(Object length) {
  return '共 $length 条评论';
}
```
英文：
```dart
@override
String postCommentsInTotal(Object length) {
  return '$length comments in total';
}
```
调用的地方：
```dart
Text(
  l10n.postCommentsInTotal(state.comments.length),
),
```

有两个使用 intl 库过程中得到的经验：

* 多个繁体中文地区复用 arb：如果对翻译非常严谨，那么港澳台的文案可能是存在差异的；但如果只是想简单处理的话，可能想港澳台复用同一个繁体中文 arb，此时就需要在 LocalizationsDelegate 的 load 方法中，将港澳台都“重映射”到同一个 Locale：
```dart
@override
Future<AppLocalizations> load(Locale locale) =>
    AppLocalizations.delegate.load(_lookupLocale(locale));
    
static Locale _lookupLocale(Locale locale) {
  if (locale.languageCode == 'zh') {
    String name = Intl.canonicalizedLocale(locale.toString());
    if (locale.countryCode?.toUpperCase() == 'HK' ||
        locale.countryCode?.toUpperCase() == 'MO' ||
        locale.countryCode?.toUpperCase() == 'TW' ||
        locale.scriptCode?.toUpperCase() == 'HANT' ||
        name.toUpperCase().contains('HANT')) {
      return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant');
    }
  }
  return Locale.fromSubtags(languageCode: locale.languageCode);
}
```
* 图片国际化：将不同语言版本的同一切图，放到以 languageCode_scriptCode 命名的对应目录中：
      
<img width="200" alt="l10n_image_structure" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/l10n_image_structure.png">

然后在代码中用 Locale.toString 来拼接得到对应语言版本的切图：

```dart
class AppImage {
  static String get locale => L10nDelegate.localeName.toString();

  static String get raffle_collectall =>
      'assets/images/l10n/$locale/win.png';
}
```

<!-- TOC --><a name="pages"></a>
# 页面展示

<!-- TOC --><a name="welcome"></a>
## 启动页 & 登录页

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/welcome/view/welcome_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/welcome/view/welcome_screen.dart)

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/login/view/login_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/login/view/login_screen.dart)

<img width="200" alt="screenshot_welcome" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_welcome.jpg">

<img width="200" alt="screenshot_login_1" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_login_1.jpg">

<img width="200" alt="screenshot_login_2" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_login_2.jpg">

启动页模拟展示开屏广告。这里假定的规则是：

* 应用初始化本身有一定耗时；在此期间尝试加载开屏广告
* 但是开屏广告不应阻塞启动，只允许尝试一定时间（如 3 秒），超时就放弃展示
代码写成等待两个异步任务：一个是初始化、另一个是加载广告。两个异步任务都完成后，如果广告已加载好，就先展示；否则直接跳转到后续页面。

两个异步任务（Future）返回类型不一样，如果写成：

```dart
final result = Future.wait([
  _appCubit.init(),  // 这个模拟应用初始化，返回 Future<void>
  completer.future,  // 这个模拟加载广告，返回 Future<SplashAd?>
]);
```
因 Future.wait 会把泛型推导为 void，导致 result 无法获取模拟的广告数据。
这里用到了 Dart 3.0 的 Records，将这两个返回对象组合成一个新类型去等待返回：

```dart
final (_, splashAd) = await (
  _appCubit.init(),
  completer.future,
).wait;
```

<!-- TOC --><a name="feed"></a>
## 主页 - Feed 流

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/home/view/home_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/home/view/home_screen.dart)

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/feed/view/feed_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/feed/view/feed_screen.dart)

<img width="200" alt="screenshot_feed_1" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_feed_1.jpg">

<img width="200" alt="screenshot_feed_2" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_feed_2.jpg">

这里展示了两种场景的 Feed 流列表样式：GridView 和 ListView。两者都需要有上拉刷新、下拉翻页加载更多、到底无更多数据时显示提示 Footer。因此基于这些共性封装成统一的组件：

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/common/widget/paging_load_widget.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/common/widget/paging_load_widget.dart)

业务代码只需提供列表 Widget 的构建方式。

<!-- TOC --><a name="feed_detail"></a>
## Feed 流详情

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/post/view/post_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/post/view/post_screen.dart)

<img width="200" alt="screenshot_feed_detail_1" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_feed_detail_1.jpg">

<img width="200" alt="screenshot_feed_detail_2" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_feed_detail_2.jpg">

<img width="200" alt="screenshot_feed_detail_3" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_feed_detail_3.jpg">

<!-- TOC --><a name="profile"></a>
## 个人主页

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/profile/view/profile_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/profile/view/profile_screen.dart)

<img width="200" alt="screenshot_profile_1" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_profile_1.jpg">

<img width="200" alt="screenshot_profile_2" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_profile_2.jpg">

这里主要的经验是做 TabBar 盖住封面图、TabBar 背景带圆角：

<img width="300" alt="screenshot_profile_tabbar" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_profile_tabbar.png">

封面图是放在 SliverAppBar 的 flexibleSpace 中的，这样才能随着 SliverAppBar 以下的滚动组件滚动折叠；TabBar 要想能盖在封面图之上，则需要放在 SliverAppBar 的 bottom 中；但一开始以为 bottom 只能接受 TabBar，就无法给 TabBar 包一层 Container 加圆角背景；

后面又尝试将 TabBar 放在 SliverPersistentHeader 中，这样 TabBar 可以被任意 Widget 包裹、也能随着下方滚动组件滚动到顶部后固定下来；但是这样 TabBar 又无法盖住 SliverAppBar 中的封面图。

后来发现 SliverAppBar 的 bottom 接受的是 PreferredSizeWidget，而 TabBar 也实现了 PreferredSizeWidget。既然如此，也就可以自己写一个 Widget 实现 PreferredSizeWidget，然后在 build 方法中用 Container 包裹 TabBar，最后一整个提供给 SliverAppBar 的 bottom。

<!-- TOC --><a name="setting"></a>
## 设置页

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/setting/view/setting_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/setting/view/setting_screen.dart)

<img width="200" alt="screenshot_setting" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_setting.jpg">

设置页里的“语言”、“主题色”选项是真实的，其余只是占位 UI。

切换语言、主题色，通过修改 MaterialApp 的 locale 和 theme 实现。

<!-- TOC --><a name="message"></a>
## 消息页

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/message/view/message_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/message/view/message_screen.dart)

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/conversation/view/conversation_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/conversation/view/conversation_screen.dart)

<img width="200" alt="screenshot_message" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_message.jpg">

<img width="200" alt="screenshot_message_detail" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_message_detail.jpg">

<img width="200" alt="gif_message" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_message.GIF">

消息页主要的经验是，实现进入消息详情页后默认“滚动”到最新的消息。

一开始是用 ScrollController 的 jumpTo 实现：

```dart
_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
```
但是因为列表需要经过布局测量，ScrollController 才能知道 maxScrollExtent 是多少，所以无法在一开始就调用 jumpTo，需要等待“post-frame”之后：
```dart
void _scrollToBottom() {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) {
      if (!mounted || !_scrollController.hasClients) {
        return;
      }
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    },
  );
}
```
这就导致一开始看到列表在顶部，下一刻忽然显示在底部，观感很不好。
搜索一番后发现有几个 stackoverflow 问答和博客提供了另一张思路，就是让 ListView 上下颠倒（reverse = true），然后构建 Item 时从列表数据的末尾开始取，这样 ListView 默认就是显示“第一条”（实际的最后一条）数据在底部，而无需经过 jumpTo。

然而如果 Item 数量不足一个屏幕高度的话，就会“露馅”：

<img width="200" alt="screenshot_message_problem" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_message_problem.png">

目前的解决办法是，给 ListView 包一层 Align 对齐 Alignment.topLeft；当列表数据不超过 10 条时（这里简单处理，没有精确计算，仅目测 10 条单行消息 Item 的高度是一个屏幕高度），设置 ListView 的 shrinkWrap 属性为 true，这样 ListView 高度仅是当前所有 Item 高度总和，然后被 Align 对齐到顶部，避免“露馅”。

<!-- TOC --><a name="sticker"></a>
## 贴纸功能

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/editor/view/editor_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/editor/view/editor_screen.dart)

<img width="200" alt="screenshot_sticker" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/screenshot_sticker.jpg">

贴纸功能基于 Github 上这个库重新修改：

[https://github.com/whenSunSet/sticker-framework-flutter](https://github.com/whenSunSet/sticker-framework-flutter)

这个库时间有点久远，写法上有点问题（如外部创建 State，再传入 StatefulWidget，以便外部可以持有 State 来调用 State 的方法）；Hot Reload 时会因为 State 里的 GlobalKey 报错，难以调试；所以就没有直接依赖，而是复制出来修改。

在此基础上增加了置顶和水平翻转功能。

<!-- TOC --><a name="visualization"></a>
## Flutter 知识点可视化

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/home/view/sample_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/home/view/sample_screen.dart)

<!-- TOC --><a name="async"></a>
### 异步

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/async/view/sample_async_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/async/view/sample_async_screen.dart)

对比在不同 isolate 中执行任务时对 UI 的影响

<img width="200" alt="gif_async_ui_task_runner" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_async_ui_task_runner.GIF">

<img width="200" alt="gif_async_isolate" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_async_isolate.GIF">

<img width="200" alt="gif_async_io_task_runner" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_async_io_task_runner.GIF">

对比异步任务串行和并行的差异

<img width="300" alt="gif_async_serial_task" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_async_serial_task.GIF">

<img width="300" alt="gif_async_parallel_task" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_async_parallel_task.GIF">

<!-- TOC --><a name="key"></a>
### Key

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/key/view/sample_key_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/key/view/sample_key_screen.dart)

通过对色块交换顺序来演示 Key 的作用

<img width="200" alt="gif_key_stateless" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_key_stateless.GIF">

<img width="200" alt="gif_key_stateful_1" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_key_stateful_1.GIF">

<img width="200" alt="gif_key_stateful_2" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_key_stateful_2.GIF">

<!-- TOC --><a name="lifecycle"></a>
### Lifecycle

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/lifecycle/view/sample_lifecycle_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/lifecycle/view/sample_lifecycle_screen.dart)

将 State 的生命周期变化过程可视化

<img width="200" alt="gif_lifecycle" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_lifecycle.GIF">

* Set：放置演示用的 Widget（带颜色和 Icon），通过 GlobalKey 标记
* Update：更新 Widget 的颜色
* Depend：IconData 由 InheritedWidget 提供；点击让 InheritedWidget 更新 IconData
* Swap：将演示 Widget 的位置变更
* Remove：移除演示 Widget

<!-- TOC --><a name="animation"></a>
### Animation

[https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/animation/view/sample_animation_screen.dart](https://github.com/SimonCherryGZ/flutter_resume/blob/main/lib/presentation/sample/animation/view/sample_animation_screen.dart)

Animation Controller

<img width="200" alt="gif_animation_controller" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_animation_controller.GIF"><br>

隐式动画

<img width="200" alt="gif_animation_implicit" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_animation_implicit.GIF"><br>

动画曲线

<img width="200" alt="gif_animation_curve" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_animation_curve.GIF"><br>

交织动画（Staggered Animation）

<img width="200" alt="gif_animation_staggered" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_animation_staggered.GIF"><br>

共享元素动画

<img width="200" alt="gif_animation_hero" src="https://raw.githubusercontent.com/SimonCherryGZ/ImageHost/main/flutter_resume/gif_animation_hero.GIF">

