import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/router/router.dart';
import 'package:flutter_resume/welcome/welcome.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<WelcomeBloc>(
        create: (context) => WelcomeBloc()..add(LoadAd()),
        lazy: false,
        child: BlocListener<WelcomeBloc, WelcomeState>(
          listenWhen: (p, c) => p.adStatus != c.adStatus,
          listener: (context, state) {
            final adStatus = state.adStatus;
            switch (adStatus) {
              case WelcomeAdStatus.failed:
              case WelcomeAdStatus.closed:
                // todo
                context.go(AppRouter.login);
                break;
              default:
                break;
            }
          },
          child: Stack(
            children: [
              const WelcomeView(),
              BlocBuilder<WelcomeBloc, WelcomeState>(
                buildWhen: (p, c) => p.adImageBytes != c.adImageBytes,
                builder: (context, state) {
                  final adImageBytes = state.adImageBytes;
                  if (adImageBytes == null) {
                    return const SizedBox.shrink();
                  }
                  return WelcomeAdView(adImageBytes);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
