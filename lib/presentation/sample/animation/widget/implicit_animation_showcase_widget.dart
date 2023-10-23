import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class ImplicitAnimationShowcaseWidget extends StatelessWidget {
  const ImplicitAnimationShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'Implicit Animation',
      content: '演示隐式动画',
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AnimatedContainerShowcase(),
            SizedBox(width: 30.ss()),
            _AnimatedSwitcherShowcase(),
          ],
        );
      },
    );
  }
}

class _AnimatedContainerShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnimatedContainerCubit(),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 100.ss(),
                child:
                    BlocBuilder<AnimatedContainerCubit, AnimatedContainerState>(
                  builder: (context, state) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: state.width,
                      height: state.height,
                      decoration: BoxDecoration(
                        shape: state.shape,
                        color: state.color,
                        border: Border.all(
                          color: state.borderColor,
                          width: state.borderWidth,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.ss()),
              ElevatedButton(
                onPressed: () {
                  context.read<AnimatedContainerCubit>().randomize();
                },
                child: const Text('Randomize'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AnimatedSwitcherShowcase extends StatefulWidget {
  @override
  State<_AnimatedSwitcherShowcase> createState() =>
      _AnimatedSwitcherShowcaseState();
}

class _AnimatedSwitcherShowcaseState extends State<_AnimatedSwitcherShowcase> {
  bool _flag = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100.ss(),
          height: 100.ss(),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> value) {
              return ScaleTransition(
                scale: value,
                child: RotationTransition(
                  turns: value,
                  child: child,
                ),
              );
            },
            switchInCurve: Curves.easeOutQuad,
            switchOutCurve: Curves.easeOutQuad,
            child: _flag
                ? Icon(
                    Icons.flutter_dash,
                    size: 80.ss(),
                  )
                : const Text(
                    'Dash',
                    style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 30.ss()),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _flag = !_flag;
            });
          },
          child: const Text('Switch'),
        ),
      ],
    );
  }
}
