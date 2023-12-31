import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final l10n = L10nDelegate.l10n(context);
    return BlocProvider(
      create: (context) => SettingBloc(appCubit),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(l10n.settingScreenTitle),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<SettingBloc, SettingState>(
              listenWhen: (p, c) => p.isShowLoading != c.isShowLoading,
              listener: (context, state) {
                final isShowLoading = state.isShowLoading;
                if (isShowLoading) {
                  EasyLoading.show();
                } else {
                  EasyLoading.dismiss();
                }
              },
            ),
          ],
          child: SettingView(
            currentLocale: appCubit.state.locale,
            currentThemeColor: appCubit.state.themeColor,
          ),
        ),
      ),
    );
  }
}
