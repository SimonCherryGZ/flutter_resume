import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class LifecycleVisualizationWidget extends StatefulWidget {
  const LifecycleVisualizationWidget({super.key});

  @override
  State<LifecycleVisualizationWidget> createState() =>
      _LifecycleVisualizationWidgetState();
}

class _LifecycleVisualizationWidgetState
    extends State<LifecycleVisualizationWidget> {
  late final StreamController<LifecycleState> _stateController;
  late Stream<LifecycleState> _stateStream;
  final _random = Random();
  final _globalKey = GlobalKey();
  final _stateQueue = Queue<LifecycleState>();
  bool _isQueueRunnerEnable = true;

  @override
  void initState() {
    super.initState();
    _stateController = StreamController<LifecycleState>.broadcast();
    _stateStream = _stateController.stream;
    _queueRunner();
  }

  @override
  void dispose() {
    _isQueueRunnerEnable = false;
    _stateController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return BlocProvider(
      create: (context) => LifecycleVisualizationCubit(),
      child: Column(
        children: [
          BlocBuilder<LifecycleVisualizationCubit, LifecycleVisualizationState>(
            buildWhen: (p, c) => p.iconData != c.iconData,
            builder: (context, state) {
              return InheritedIconDataWidget(
                state.iconData,
                child: BlocBuilder<LifecycleVisualizationCubit,
                    LifecycleVisualizationState>(
                  buildWhen: (p, c) =>
                      (p.position != c.position || p.color != c.color),
                  builder: (context, state) {
                    final widget = Center(
                      child: LifecycleCallbackWidgetWrapper(
                        key: _globalKey,
                        stateCallback: _handleStateCallback,
                        color: state.color,
                      ),
                    );
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade300,
                          child: (LifecycleVisualizationWidgetPosition.left ==
                                  state.position)
                              ? widget
                              : null,
                        ),
                        const SizedBox(width: 40),
                        Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade300,
                          child: (LifecycleVisualizationWidgetPosition.right ==
                                  state.position)
                              ? widget
                              : null,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LifecycleVisualizationItemWidgetWrapper(
                      label: 'initState',
                      stream: _stateStream
                          .where((state) => state == LifecycleState.initState),
                    ),
                    const Icon(Icons.arrow_downward),
                    LifecycleVisualizationItemWidgetWrapper(
                      label: 'didChangeDependencies',
                      stream: _stateStream.where((state) =>
                          state == LifecycleState.didChangeDependencies),
                    ),
                    const Icon(Icons.arrow_downward),
                    LifecycleVisualizationItemWidgetWrapper(
                      label: 'build',
                      stream: _stateStream
                          .where((state) => state == LifecycleState.build),
                    ),
                    const Icon(Icons.arrow_downward),
                    LifecycleVisualizationItemWidgetWrapper(
                      label: 'deactivate',
                      stream: _stateStream
                          .where((state) => state == LifecycleState.deactivate),
                    ),
                    const Icon(Icons.arrow_downward),
                    LifecycleVisualizationItemWidgetWrapper(
                      label: 'dispose',
                      stream: _stateStream
                          .where((state) => state == LifecycleState.dispose),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 75.ss()),
                  const Icon(Icons.arrow_back),
                  SizedBox(height: 50.ss()),
                  const Icon(Icons.arrow_forward),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 75.ss()),
                    LifecycleVisualizationItemWidgetWrapper(
                      label: 'didUpdateWidget',
                      stream: _stateStream.where(
                          (state) => state == LifecycleState.didUpdateWidget),
                    ),
                    const Icon(Icons.arrow_upward),
                    LifecycleVisualizationItemWidgetWrapper(
                      label: 'activate',
                      stream: _stateStream
                          .where((state) => state == LifecycleState.activate),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 30),
          BlocBuilder<LifecycleVisualizationCubit, LifecycleVisualizationState>(
            buildWhen: (p, c) => p.position != c.position,
            builder: (context, state) {
              final cubit = context.read<LifecycleVisualizationCubit>();
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 4.ss()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (state.position ==
                        LifecycleVisualizationWidgetPosition.none) ...[
                      ElevatedButton(
                        onPressed: () {
                          cubit.setWidget();
                        },
                        child: Text(
                            l10n.lifecycleVisualizationShowcaseSetButtonText),
                      ),
                    ],
                    if (state.position !=
                        LifecycleVisualizationWidgetPosition.none) ...[
                      ElevatedButton(
                        onPressed: () {
                          final color = Colors.primaries[
                              _random.nextInt(Colors.primaries.length)];
                          cubit.updateColor(color);
                        },
                        child: Text(l10n
                            .lifecycleVisualizationShowcaseUpdateButtonText),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cubit.switchIconData();
                        },
                        child: Text(l10n
                            .lifecycleVisualizationShowcaseDependButtonText),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cubit.swapPosition();
                        },
                        child: Text(
                            l10n.lifecycleVisualizationShowcaseSwapButtonText),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cubit.removeWidget();
                        },
                        child: Text(l10n
                            .lifecycleVisualizationShowcaseRemoveButtonText),
                      ),
                    ],
                  ].withSpaceBetween(width: 4.ss()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleStateCallback(LifecycleState state) {
    _stateQueue.add(state);
  }

  void _queueRunner() async {
    while (_isQueueRunnerEnable) {
      if (_stateQueue.isEmpty) {
        await Future.delayed(const Duration(milliseconds: 33));
      }
      if (_stateQueue.isNotEmpty) {
        final state = _stateQueue.removeFirst();
        if (_stateController.isClosed) {
          return;
        }
        _stateController.add(state);
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }
}

enum LifecycleState {
  initState,
  didChangeDependencies,
  build,
  didUpdateWidget,
  activate,
  deactivate,
  dispose,
}
